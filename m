From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/2] serial: Hack up 8520.c for evil device tree
 hookin.
Date: Thu, 17 Mar 2011 01:46:11 +0000
Message-ID: <20110317014611.67d360b5@lxorguk.ukuu.org.uk>
References: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57707 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752654Ab1CQBqP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 21:46:15 -0400
In-Reply-To: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

> is correct.  When I put the code in my board's serial.c file, I am not
> so lucky.  To get the initialization order correct, I add a notifier
> chain to 8250.c

Can't you use a late_initcall ? or indeed we could make the 8250 core
functionality only init first ?

Alan
