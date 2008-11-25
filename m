From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 10:43:34 +0000
Message-ID: <20081125104334.351e94ee@lxorguk.ukuu.org.uk>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
	<1227585503-3833-1-git-send-email-sheng@linux.intel.com>
	<20081125102230.791fa168@lxorguk.ukuu.org.uk>
	<200811251831.34737.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60710 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189AbYKYKnX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 05:43:23 -0500
In-Reply-To: <200811251831.34737.sheng@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sheng Yang <sheng@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> Can't understand initializing got "risk hiding future ones". As I know, didn't 

Because if you set it to NULL and later delete a line which does the
intended assignment you will no longer get a warning.

> think BUG_ON(n==null) cover this. And I don't think leave it to compiler is 
> more proper here.

The BUG_ON covers it, the current gcc gets this right and works it out.

NAK again

