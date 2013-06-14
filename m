From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty/vt: Return EBUSY if deallocating VT1 and it is busy
Date: Fri, 14 Jun 2013 19:01:56 -0400
Message-ID: <51BBA0E4.6030602@hurleysoftware.com>
References: <20130614213543.GA1896@kroah.com> <1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:57797 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751294Ab3FNXCA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 19:02:00 -0400
In-Reply-To: <1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>

On 06/14/2013 06:24 PM, Ross Lagerwall wrote:
> Commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock order") changed
> the behavior when deallocating VT 1.  Previously if trying to
> deallocate VT1 and it is busy, we would return EBUSY.  The commit
> changed this to return 0 (success).
>
> This commit restores the old behavior.
>
> Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>

Thanks.

Acked-by: Peter Hurley <peter@hurleysoftware.com>

