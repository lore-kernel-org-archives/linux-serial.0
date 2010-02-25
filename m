From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/2] serial: Add driver for the Altera JTAG UART
Date: Thu, 25 Feb 2010 17:45:33 +0100
Message-ID: <87ocjd5knm.fsf@macbook.be.48ers.dk>
References: <1267108523-32767-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:13483 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948Ab0BYQvh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 11:51:37 -0500
In-Reply-To: <1267108523-32767-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 25 Feb 2010 15:35:22 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

>>>>> "Tobias" == Tobias Klauser <tklauser@distanz.ch> writes:

 Tobias> Add an UART driver for the JTAG UART component available as a SOPC
 Tobias> (System on Programmable Chip) component for Altera FPGAs.

 Tobias> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
 
 Tobias> +config SERIAL_ALTERA_JTAGUART
 Tobias> +	bool "Altera JTAG UART support"
 Tobias> +	depends on EMBEDDED

Don't depend on EMBEDDED - There's embedded devices not using
CONFIG_EMBEDDED and kernel configs for PCs using it.

-- 
Bye, Peter Korsgaard
