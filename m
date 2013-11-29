From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: tty/serial eating \n regression in 3.13-rc1
Date: Fri, 29 Nov 2013 07:39:45 -0500
Message-ID: <52988B11.3090300@hurleysoftware.com>
References: <20131127181348.GA22723@obsidianresearch.com> <1385652419-4732-1-git-send-email-peter@hurleysoftware.com> <20131128174614.GB28055@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:59503 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754409Ab3K2Mjt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 07:39:49 -0500
In-Reply-To: <20131128174614.GB28055@obsidianresearch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/28/2013 12:46 PM, Jason Gunthorpe wrote:
> On Thu, Nov 28, 2013 at 10:26:57AM -0500, Peter Hurley wrote:
>
>> Please test out the attached patch and let me know if that solves
>> the login whitespace problem.
>
> Yes, it certainly does:
> Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>
> My bisection search showed this should go into 3.12 stable and 3.13..

Greg,

Please let me know if you need me to resend the earlier patch with
Jason's Tested-by and a proper Cc to stable.

Regards,
Peter Hurley

