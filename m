From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 11:13:42 +0000
Message-ID: <20081125111342.5383c957@lxorguk.ukuu.org.uk>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
	<200811251831.34737.sheng@linux.intel.com>
	<20081125104334.351e94ee@lxorguk.ukuu.org.uk>
	<200811251851.44768.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46958 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752602AbYKYLNc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 06:13:32 -0500
In-Reply-To: <200811251851.44768.sheng@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sheng Yang <sheng@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> The logic here is strange...

Why

> If you used old compiler, you would get a warning, and you thought that's 
> ensured we won't delete a intended assignment by mistake.

No.. if you hid the warning by hacking around the compiler mistake with
extra bogus assignments you would hide a future mistake.
> 
> If you used new compiler, you wouldn't get a warning, and you think this time 
> the compiler get it right.

The compiler does now get it right - I checked.

Alan
