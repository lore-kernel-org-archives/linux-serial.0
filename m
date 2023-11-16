Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B954C54FB9
	for <linux-serial@archiver.kernel.org>; Thu, 16 Nov 2023 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjKPKdb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Nov 2023 05:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPKda (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Nov 2023 05:33:30 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7801AE;
        Thu, 16 Nov 2023 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=KOCiWUhMH4hnxHlWOWnGeGYkeEeB5aUu205Zvuz11KU=; b=cEoL1JoVdqwT9mHr0UlV0Sx71j
        IztOapDuFS5+FCzgG760gnCgwl/yKCtjGmGsL4vtPwPMHpSsSlojB7A/lDpIFo7yCE8A1Se0EwV1P
        ZmVLZLGD3iDi3VMnyik5h3bRV2NTqYx8jz2YjhEpx7h6jmAseNVILhkTaUCLVy8boq0g=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34750 helo=asus64.hugovil.com)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r3ZgQ-0000qg-UU; Thu, 16 Nov 2023 05:33:15 -0500
Date:   Thu, 16 Nov 2023 05:33:14 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>,
        <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>
Message-Id: <20231116053314.e976a87476cc5bc20eacde48@hugovil.com>
In-Reply-To: <20231116072915.3338387-2-manikanta.guntupalli@amd.com>
References: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
        <20231116072915.3338387-2-manikanta.guntupalli@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH V3 1/2] Documentation: devices.txt: Update ttyUL major
 number allocation details
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 16 Nov 2023 12:59:14 +0530
Manikanta Guntupalli <manikanta.guntupalli@amd.com> wrote:

Hi,

> Describe when uartlite driver uses static/dynamic allocation for major
> number based on maximum number of uartlite serial ports.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> This patch introduced in V2.
> Changes for V3:
> Fix typo.
> Move description to above of ttyUL.
> ---
>  Documentation/admin-guide/devices.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 839054923530..ae7431e317ad 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -2704,6 +2704,9 @@
>  		    ...
>  		 185 = /dev/ttyNX15		Hilscher netX serial port 15
>  		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
> +
> +		 If maximum number of uartlite serial ports are more than 4, then driver uses

"are more" -> "is more"

"then driver" -> "the driver" (or "then the driver")

Hugo.


> +		 dynamic allocation instead of static allocation for major number.
>  		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
>  		    ...
>  		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
> -- 
> 2.25.1
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
