From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix the warning of uninitialized value in
 driver/serial/8250.c
Date: Tue, 3 Feb 2009 17:21:47 +0000
Message-ID: <20090203172147.18136ed1@the-village.bc.nu>
References: <4986B86E.3030604@oracle.com>
	<200902021103.21887.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45836 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbZBCRyv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Feb 2009 12:54:51 -0500
In-Reply-To: <200902021103.21887.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: wenji.huang@oracle.com, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

> gcc is wrong, i can't be used uninitialized in that function. You should use 
> the following construct instead to suppress the warning without generating any 
> code.

No need for that either - newer gcc gets it right.
