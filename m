From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 09:13:34 -0500
Message-ID: <48888E0E.3050601@commtech-fastcom.com>
References: <200807241347.33261.laurentp@cse-semaphore.com> <20080724125706.19844a96@lxorguk.ukuu.org.uk> <20080724122402.GC9327@flint.arm.linux.org.uk> <20080724132746.1a961584@lxorguk.ukuu.org.uk> <20080724125210.GD9327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:42946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYGXONl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 10:13:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1079461nfc.21
        for <linux-serial@vger.kernel.org>; Thu, 24 Jul 2008 07:13:40 -0700 (PDT)
In-Reply-To: <20080724125210.GD9327@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Laurent Pinchart <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

Russell King wrote:
> 
> It's true of all 8250 compatibles which don't have hardware RS485
> support.  I think that's all of them except 16850 and 16960.
> 

Just for the sake of completeness, the Oxford Semi 16c950 also has 
hardare 485 control, as do Exar's PCI based 17d15x UARTs.


Matt Schulte
Commtech, Inc.

