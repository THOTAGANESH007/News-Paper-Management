package com.models;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class ForOtp {
	private static final Set<Integer> uniqueNumbers = new HashSet<>();
	private static final Random random = new Random();

	public static int generateUniqueFourDigitNumber() {
		int number;
		do {
			number = 1000 + random.nextInt(9000); // Generates a number between 1000 and 9999
		} while (uniqueNumbers.contains(number)); // Ensure it's unique

		uniqueNumbers.add(number); // Add to the set of unique numbers
		return number;
	}
}
