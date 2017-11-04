// #include <cstddef>
// #include "string"
#include <string.h>
#include "fstream"
#include <vector>
#include <unordered_map>
#include <iostream>
#include <utility>
#include <map>
#include <string>

namespace sha1
{
  namespace // local
  {
      // Rotate an integer value to left.
      inline const unsigned int rol(const unsigned int value,
              const unsigned int steps)
      {
          return ((value << steps) | (value >> (32 - steps)));
      }

      // Sets the first 16 integers in the buffert to zero.
      // Used for clearing the W buffert.
      inline void clearWBuffert(unsigned int* buffert)
      {
          for (int pos = 16; --pos >= 0;)
          {
              buffert[pos] = 0;
          }
      }

      void innerHash(unsigned int* result, unsigned int* w)
      {
          unsigned int a = result[0];
          unsigned int b = result[1];
          unsigned int c = result[2];
          unsigned int d = result[3];
          unsigned int e = result[4];

          int round = 0;

          #define sha1macro(func,val) \
    { \
              const unsigned int t = rol(a, 5) + (func) + e + val + w[round]; \
      e = d; \
      d = c; \
      c = rol(b, 30); \
      b = a; \
      a = t; \
    }

          while (round < 16)
          {
              sha1macro((b & c) | (~b & d), 0x5a827999)
              ++round;
          }
          /*
          while (round < 20)
          {
              w[round] = rol((w[round - 3] ^ w[round - 8] ^ w[round - 14] ^ w[round - 16]), 1);
              sha1macro((b & c) | (~b & d), 0x5a827999)
              ++round;
          }
          while (round < 40)
          {
              w[round] = rol((w[round - 3] ^ w[round - 8] ^ w[round - 14] ^ w[round - 16]), 1);
              sha1macro(b ^ c ^ d, 0x6ed9eba1)
              ++round;
          }
          
          while (round < 60)
          {
              w[round] = rol((w[round - 3] ^ w[round - 8] ^ w[round - 14] ^ w[round - 16]), 1);
              sha1macro((b & c) | (b & d) | (c & d), 0x8f1bbcdc)
              ++round;
          }
          while (round < 80)
          {
              w[round] = rol((w[round - 3] ^ w[round - 8] ^ w[round - 14] ^ w[round - 16]), 1);
              sha1macro(b ^ c ^ d, 0xca62c1d6)
              ++round;
          }*/

          #undef sha1macro

          result[0] += a;
          result[1] += b;
          result[2] += c;
          result[3] += d;
          result[4] += e;
      }
  } // namespace


    /**
     @param src points to any kind of data to be hashed.
     @param bytelength the number of bytes to hash from the src pointer.
     @param hash should point to a buffer of at least 20 bytes of size for storing the sha1 result in.
     */
    void calc(const void* src, const size_t bytelength, unsigned char* hash)
    {
      // Init the result array.
      unsigned int result[5] = { 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0 };
      
      // Cast the void src pointer to be the byte array we can work with.
      const unsigned char* sarray = (const unsigned char*) src;

      // The reusable round buffer
      unsigned int w[80];

      // Loop through all complete 64byte blocks.
      const int endOfFullBlocks = (int) bytelength - 64;
      int endCurrentBlock;
      int currentBlock = 0;

      while (currentBlock <= endOfFullBlocks)
      {
          endCurrentBlock = currentBlock + 64;

          // Init the round buffer with the 64 byte block data.
          for (int roundPos = 0; currentBlock < endCurrentBlock; currentBlock += 4)
          {
              // This line will swap endian on big endian and keep endian on little endian.
              w[roundPos++] = (unsigned int) sarray[currentBlock + 3]
                      | (((unsigned int) sarray[currentBlock + 2]) << 8)
                      | (((unsigned int) sarray[currentBlock + 1]) << 16)
                      | (((unsigned int) sarray[currentBlock]) << 24);
          }
          innerHash(result, w);
      }

      // Handle the last and not full 64 byte block if existing.
      endCurrentBlock = (int) bytelength - currentBlock;
      clearWBuffert(w);
      int lastBlockBytes = 0;
      for (;lastBlockBytes < endCurrentBlock; ++lastBlockBytes)
      {
          w[lastBlockBytes >> 2] |= (unsigned int) sarray[lastBlockBytes + currentBlock] << ((3 - (lastBlockBytes & 3)) << 3);
      }
      w[lastBlockBytes >> 2] |= 0x80 << ((3 - (lastBlockBytes & 3)) << 3);
      if (endCurrentBlock >= 56)
      {
          innerHash(result, w);
          clearWBuffert(w);
      }
      w[15] = (int) bytelength << 3;
      innerHash(result, w);

      // Store hash in result pointer, and make sure we get in in the correct order on both endian models.
      for (int hashByte = 20; --hashByte >= 0;)
      {
          hash[hashByte] = (result[hashByte >> 2] >> (((3 - hashByte) & 0x3) << 3)) & 0xff;
      }
    };

    /**
     @param hash is 20 bytes of sha1 hash. This is the same data that is the result from the calc function.
     @param hexstring should point to a buffer of at least 41 bytes of size for storing the hexadecimal representation of the hash. A zero will be written at position 40, so the buffer will be a valid zero ended string.
     */
    void toHexString(const unsigned char* hash, char* hexstring)
    {
      const char hexDigits[] = { "0123456789abcdef" };
        for (int hashByte = 20; --hashByte >= 0;)
        {
          hexstring[hashByte << 1] = hexDigits[(hash[hashByte] >> 4) & 0xf];
          hexstring[(hashByte << 1) + 1] = hexDigits[hash[hashByte] & 0xf];
        }
        hexstring[40] = 0;
    };
} // namespace sha1

class ProcessData
{
private:
	std::unordered_map<std::string, std::string> *mHashedDictionary;
	std::vector<std::pair<std::string, std::string> > mSolvedPasswords;
	std::multimap<std::string, int> mPasswordsToBruteForce;

	/* HELPER FUNCTIONS */
	/* Converts 0-35 to a char */
	char ConvertToChar(int number)
	{
		// Handle numbers 0-9
		if (number >= 0 && number <= 9)
		return '0' + number;
		// Convert the number to a letter (a-z)
		return static_cast<char>(number + 87);
	};
	/* Brute Force helper function */
	void BruteForceInRange(std::multimap<std::string, int> &passwordsToCrack, int from, int to)
	{
		// Counting machine to generate all 4 character permutations
		int arr[4] = { 0 };
		arr[0] = from;
		while (arr[0] <= to)
		{
			arr[3]++;
			if (arr[3] > 35)
			{
				arr[3] = 0;
				arr[2]++;
				if (arr[2] > 35)
				{
					arr[2] = 0;
					arr[1]++;
					if (arr[1] > 35)
					{
						arr[1] = 0;
						arr[0]++;
					}
				}
			}
			// Check the phrases of length 1, 2, 3, 4
			std::string phrase = { ConvertToChar(arr[0]), ConvertToChar(arr[1]), ConvertToChar(arr[2]), ConvertToChar(arr[3]) };
			ProcessPermutation(phrase);
			if (arr[0] == 0)
			{
				phrase = { ConvertToChar(arr[1]), ConvertToChar(arr[2]), ConvertToChar(arr[3]) };
				ProcessPermutation(phrase);
				if (arr[1] == 0)
				{
					phrase = { ConvertToChar(arr[1]), ConvertToChar(arr[2]), ConvertToChar(arr[3]) };
					ProcessPermutation(phrase);
					if (arr[2] == 0)
					{
						phrase = { ConvertToChar(arr[1]), ConvertToChar(arr[2]), ConvertToChar(arr[3]) };
						ProcessPermutation(phrase);
					}
				}
			}
		}
	};
	/* Checks mPasswordsToBruteForce against a single permutation */
	void ProcessPermutation(std::string const &phrase)
	{
		// Hash the input phrase
		std::string hashedPermutation = CalculateHash(phrase);
		// Check it against the unsolved passwords and update the solved passwords
		auto searchResult = mPasswordsToBruteForce.equal_range(hashedPermutation);
		for (auto crackedIdx = searchResult.first; crackedIdx != searchResult.second; ++crackedIdx)
		{
			mSolvedPasswords[crackedIdx->second].second = phrase;
		}
	};

public:
	ProcessData() { mHashedDictionary = new std::unordered_map<std::string, std::string>(100000); };
	~ProcessData() { delete mHashedDictionary; };

	/* Crack Passwords */
	void CrackPasswords(char * dictFile, char * passFile)
	{
		CalculateDictionaryHashes(dictFile);
		DictionaryAttack(passFile);
		// BruteForceAttackParallel();
		// BruteForceAttackSingleThreaded();
		WritePasswordToFile();
	};
	/* Hashes a char* string */
	std::string CalculateHash(char * input)
	{
		// Hash the input password
		unsigned char hash[20];
		sha1::calc(input, strlen(input), hash);

		char hex_str[41];
		sha1::toHexString(hash, hex_str);

		std::string s(hex_str);
		return s;
	};
	/* Hashes a std::string string */
	std::string CalculateHash(std::string const &input)
	{
		// Hash the input password
		unsigned char hash[20];
		sha1::calc(input.c_str(), input.length(), hash);

		char hex_str[41];
		sha1::toHexString(hash, hex_str);

		std::string s(hex_str);
		return s;
	};
	/* Calculates hashes from an input file */
	void CalculateDictionaryHashes(char * dictionary)
	{
		std::ifstream dictFile(dictionary);
		if (!dictFile.is_open())
		{
			std::cerr << "Cannot open dictionary file.\n";
		}
		std::string phrase;
		while (std::getline(dictFile, phrase))
		{
			std::string hashedPhrase = CalculateHash(phrase);
			mHashedDictionary->insert(std::make_pair(hashedPhrase, phrase));
		}
		std::cout << "The dictionary has been loaded.\n";
		dictFile.close();
	};
	/* Perform a dictionarry attack on an input file with hashed password */
	void DictionaryAttack(char * passwordFilename)
	{
		std::ifstream passwordFile(passwordFilename);
		if (!passwordFile.is_open())
		{
			std::cerr << "Cannot open passwords file\n";
			return;
		}
	
		std::string hashToCrack;
		// Check all the input passwords against mHashedDisctionary and store them to mSolvedPasswords
		// If can't find password stores the value as ??
		while (getline(passwordFile, hashToCrack))
		{
			auto searchResult = mHashedDictionary->find(hashToCrack);
			std::pair<std::string, std::string> crackAttempt;
			crackAttempt.first = hashToCrack;
			if (searchResult == mHashedDictionary->end())
			{
				crackAttempt.second = "??";
			}
			else
			{
				crackAttempt.second = searchResult->second;
			}
			mSolvedPasswords.push_back(crackAttempt);
			if (crackAttempt.second == "??")
			{
				mPasswordsToBruteForce.insert({hashToCrack, mSolvedPasswords.size() - 1});
			}
		}
		std::cout << "Dictionary attack finished.\n";
		passwordFile.close();
	};
	// /* Perform a Single Threaded Brute Force attack */
	// void BruteForceAttackSingleThreaded()
	// {
	// 	BruteForceInRange(mPasswordsToBruteForce, 0, 5);
	// 	std::cout << "Brute force attack (serial) finished.\n";
	// };
	// /* Perform a Parallel Brute Force attack */
	// void BruteForceAttackParallel()
	// {
	// 	BruteForceInRange(mPasswordsToBruteForce, 0, 3);
	// 	BruteForceInRange(mPasswordsToBruteForce, 4, 7);
	// 	BruteForceInRange(mPasswordsToBruteForce, 8, 11);
	// 	BruteForceInRange(mPasswordsToBruteForce, 12, 15);
	// 	BruteForceInRange(mPasswordsToBruteForce, 16, 19);
	// 	BruteForceInRange(mPasswordsToBruteForce, 20, 23);
	// 	BruteForceInRange(mPasswordsToBruteForce, 24, 27);
	// 	BruteForceInRange(mPasswordsToBruteForce, 28, 31);
	// 	BruteForceInRange(mPasswordsToBruteForce, 32, 35);

	// 	std::cout << "Brute force attack (parallel) finished.\n";
	// };
	/* Writes mSolvedPasswords to a file */
	void WritePasswordToFile()
	{
		std::ofstream crackedPwrdsFile("pass_solved.txt");
		if (crackedPwrdsFile.is_open())
		{
			for (const auto& password : mSolvedPasswords)
			{
				crackedPwrdsFile << password.first << "," << password.second << std::endl;
			}
		}
		crackedPwrdsFile.close();
	};
};

int main(int argc, char* argv[])
{
	ProcessData dataProcessor;
	// Basic hashing
//	if (argc == 2)
//	{
//		std::cout << dataProcessor.CalculateHash(argv[1]) << std::endl;
//	}

	// Password cracking attack
	if (argc == 3)
	{
		// argv[1] - dictionary file
		// argv[2] - password file
		dataProcessor.CrackPasswords(argv[1], argv[2]);
	}

	return 0;
}
