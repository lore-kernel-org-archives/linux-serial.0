From: ael <law_ence.dev@ntlworld.com>
Subject: Re: Regression: 8250 with 2.6.24
Date: Fri, 15 Feb 2008 20:40:50 +0000
Message-ID: <fp4tcj$gn6$1@ger.gmane.org>
References: <foi71k$pem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33114 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbYBOUlE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Feb 2008 15:41:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JQ7Mi-0006gN-3L
	for linux-serial@vger.kernel.org; Fri, 15 Feb 2008 20:41:00 +0000
Received: from cpc2-oxfd6-0-0-cust55.oxfd.cable.ntl.com ([86.3.132.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 15 Feb 2008 20:41:00 +0000
Received: from law_ence.dev by cpc2-oxfd6-0-0-cust55.oxfd.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 15 Feb 2008 20:41:00 +0000
In-Reply-To: <foi71k$pem$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

For the record, this bug seems to be associated with 8250_pnp.

Under 2.6.24.2, if 8250_pnp is blacklisted and 8250_pci is explicity
loaded while booting, then /dev/ttyS{0,1,2,3} are created and accessing
ttyS0 and ttyS1 works.

Given the original nondetermination, I cannot be sure this is reliable,
but it has worked in every test so far.

I am not clear why 8250_pci does not get loaded automatically.

A Lawrence

