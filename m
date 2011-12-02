From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/3] serial: make bugs field not specific to 8250 type
 uarts.
Date: Fri, 2 Dec 2011 00:51:50 +0000
Message-ID: <20111202005150.2e9fde43@bob.linux.org.uk>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
	<1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5199 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab1LBAkV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Dec 2011 19:40:21 -0500
In-Reply-To: <1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@suse.de, galak@kernel.crashing.org, scottwood@freescale.com, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

> Make the bugs field part of the globally visible struct
> uart_port and remove the 8250 specific one.

Except all the bits in it are 8250 specific things or names that are
meaningless in generic form - no. I also don't want to encourage flags
and bug bits. We already have too many and its making the code a mess.
So right now we want less not more.
