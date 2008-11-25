From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 18:51:44 +0800
Message-ID: <200811251851.44768.sheng@linux.intel.com>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com> <200811251831.34737.sheng@linux.intel.com> <20081125104334.351e94ee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:64684 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752592AbYKYKz3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 05:55:29 -0500
In-Reply-To: <20081125104334.351e94ee@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tuesday 25 November 2008 18:43:34 Alan Cox wrote:
> > Can't understand initializing got "risk hiding future ones". As I know,
> > didn't
>
> Because if you set it to NULL and later delete a line which does the
> intended assignment you will no longer get a warning.
>
> > think BUG_ON(n==null) cover this. And I don't think leave it to compiler
> > is more proper here.
>
> The BUG_ON covers it, the current gcc gets this right and works it out.
>
> NAK again

The logic here is strange...

If you used old compiler, you would get a warning, and you thought that's 
ensured we won't delete a intended assignment by mistake.

If you used new compiler, you wouldn't get a warning, and you think this time 
the compiler get it right.

So, what result did you expect? A warning to notice that we didn't delete a 
intended assignment, or a "right" result? 

OK. if you worry about "delete a line which does the intended assignment", the 
updated version with BUG_ON(i == NULL) can help. 

-- 
regards
Yang, Sheng

