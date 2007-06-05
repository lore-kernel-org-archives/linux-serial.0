From: Chris Snook <csnook@redhat.com>
Subject: Re: [PATCH TRIVIAL] icom whitespace cleanups
Date: Tue, 05 Jun 2007 19:00:17 -0400
Message-ID: <4665EB01.5040508@redhat.com>
References: <4665D3EC.60404@redhat.com> <18021.55632.359206.105260@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39533 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822AbXFEXAu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jun 2007 19:00:50 -0400
In-Reply-To: <18021.55632.359206.105260@cargo.ozlabs.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Paul Mackerras wrote:
> Chris Snook writes:
> 
>> Clean up whitespace and comments in drivers/serial/icom.c
> 
> These changes seem totally unnecessary, as the existing indentation is
> according to a commonly-accepted style and is quite reasonable:

There are actually a few different indentation styles used inconsistently 
throughout, which I personally find annoying, and there's lots of whitespace 
damage.  If I've really overstepped the bounds, I'll resubmit a somewhat smaller 
patch, but I'm inclined to make it look pretty while I've got the hood up.

> Also you don't seem to have cc'd the driver author.

Can't find any contact info.  Care to enlighten me?

	-- Chris
