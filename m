From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] tty_ioctl: Fix the baud_table check in encode_baud_rate
Date: Tue, 23 Oct 2007 18:32:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710231828180.8693@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
 <471543C3.3050502@tiscali.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:33268 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbXJWRdG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2007 13:33:06 -0400
In-Reply-To: <471543C3.3050502@tiscali.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 17 Oct 2007, Roel Kluin wrote:

> 		if (oclose >= abs(obaud - baud_table[i])) {
> 
> should work as well

 Hmm, I am not sure if it is clearer or produces better code, but send a 
patch -- I will not object.

  Maciej
