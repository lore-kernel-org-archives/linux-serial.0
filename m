From: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: [PATCH] Don't shutdown TX on mpc5200 serial port if it is a console
Date: Fri, 20 Apr 2007 15:28:04 +0200
Message-ID: <4628BFE4.2090801@semihalf.com>
References: <11770117743675-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.semihalf.com ([62.233.211.107]:37455 "EHLO
	mail.semihalf.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbXDTNxj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Apr 2007 09:53:39 -0400
In-Reply-To: <11770117743675-git-send-email-grant.likely@secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, Sylvain Munaut <tnt@246tnt.com>, Wolfgang Denk <wd@denx.de>

Grant Likely wrote:
> If the serial port gets shut down, then console output stalls.  9 out
> of 10 kernel hackers agree, this is a bad thing.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Wolfgang, please verify this new patch.  Sylvain rightly pointed out that
> RX and interrupts should be turned off regardless.  If it works for you,
> please reply with a Signed-of-by line.

Patch verified on a MPC5200B-based board.

Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>


Regards,
Bartlomiej
