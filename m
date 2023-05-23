Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA7C7EE26
	for <linux-serial@archiver.kernel.org>; Tue, 23 May 2023 11:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjEWLN5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 May 2023 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLN4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 May 2023 07:13:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA1126
        for <linux-serial@vger.kernel.org>; Tue, 23 May 2023 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684840434; x=1716376434;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qMLRIlk0YiD2uRJqz12fYMEUWWT4LAvQ6bC4oIDwIME=;
  b=hzq/Wc400uj5rb2pZIikkyzuJUjjr4zLUOi5k2m+0sDqWV3ffaS/WJ+w
   KXdSUac7jfZBm1j8w1IwouswtV6tDxP0A0+KEt1bKftwINpoJtfPsYy3/
   WQiZMvRy8EQQ7m/Z1w+IFLbqZQPCZ3JDbBr2j0I6tZt9fJ3c5vw4aJRVi
   I42chSyUHugzimIBwZzdleWaPLoETp625/MG0WDjiBOYdfAFM+C0FEr+8
   XXJU8AUb5cM9PwSGN3EEg4eAPpWEIpHER0NJvVpmPpo75XbplP4OmUb1l
   7pr4DV/cwSoyorWcblgbveniGIkFoFtSzP0/JJ0X9XUPWrrb7svtRNPvG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418915568"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="418915568"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 04:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="654333844"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="654333844"
Received: from oodnolex-mobl1.ccr.corp.intel.com ([10.252.55.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 04:13:53 -0700
Date:   Tue, 23 May 2023 14:13:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Tresidder <rtresidd@electromag.com.au>
cc:     linux-serial@vger.kernel.org
Subject: Re: Possible regression in 8250_dw driver
In-Reply-To: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
Message-ID: <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com>
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1647315239-1684836582=:3565"
Content-ID: <11467ebe-a996-7fd1-fa85-66478163f4fd@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1647315239-1684836582=:3565
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4d3a3e30-2528-9052-f8ad-fa11c49c51d@linux.intel.com>

On Tue, 23 May 2023, Richard Tresidder wrote:

> Hi
>    We seem to be getting corruption of received data from a ublox GPS unit
> To me it looks like a fifo overrun of some sort??

Overruns should be logged (in dmesg or /proc/tty/driver/serial).

> background:
> I'm attempting to use 6.3.3 as a new base for one of our systems.
> Previously it was using 5.1.7 as a base.
> The uart in question is one of the two in the Cyclone V SOC HPS.
> And to muddy the waters the linux console TTYS0 is the other Uart from the
> same HPS core
> Yet the console appears to be working ok.

Maybe some of the DMA related changes triggering some unexpected behavior. 

Console doesn't use DMA so that could explain the difference.

> Note all other libs and apps are at the same revision and build, it is only
> the kernel that is different.
> Both versions of the kernel are also built using the same bitbake bsdk..
> 
> Seeing the following with 6.3.3:
> 
>  00000000: 45 58 54 20 43 4F 52 45 20 33 2E 30 31 20 28 31  | EXT CORE 3.01 (1
>  00000010: 31 31 31 34 31 29 00 00 00 00 00 00 00 00 30 30  | 11141)........00
>  00000020: 30 38 30 30 30 30 00 00 52 4F 4D 20 42 41 53 45  | 080000..ROM BASE
>  00000030: 20 32 2E 30 31 20 28 37 35 33 33 31 53 00 00 00  | 2.01 (75331S...
>  00000040: 00 00 00 00 00 00 00 00 00 00 00 00 53 42 41 53  | ............SBAS
>  00000050: 3B 49 4D 45 53 3B 51 5A 53 53 00 00 00 00 00 00  | ;IMES;QZSS......
>  00000060: 00 00 00 00 00 00 00 00 00 00 01 3D 29 00 00 00  | ...........=)...
>  00000070: 00 00 00 00 00 00 46 57 56 45 52 3D 54 49 4D 20  | ......FWVER=TIM
>  00000080: 31 2E 31 30 00 00 00 00 00 00 00 00 00 00 00 00  | 1.10............
>  00000090: 00 00 00 00 50 52 4F 54 56 45 52 3D 32 32 2E 30  | ....PROTVER=22.0
>  000000a0: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | 0...............
>  000000b0: 00 00 4D 4F 44 3D 4C 45 41 2D 4D 38 54 2D 30 00  | ..MOD=LEA-M8T-0.
>  000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
>  000000d0: 46 49 53 3D 30 78 45 46 34 30 31 35 20 28 31 30  | FIS=0xEF4015 (10
>  000000e0: 30 31 31 31 29 00 00 00 00 00 00 00 00 00 47 50  | 0111).........GP
>  000000f0: 53 3B 47 4C 4F 3B 47 41 4C 3B 42 44 00 00 00 00  | S;GLO;GAL;BD....
>  00000100: 00 00                                            | ..
> 
> But should be seeing this as shown on 5.1.7:
> Excuse the offset (due to this frame also showing the packet id's and lengths)
> But the body of the frame is what we should be seeing.
> 
> 00000000:  B5 62 0A 04 FA 00 45 58 54 20 43 4F 52 45 20 33  | µb..ú.EXT CORE 3
> 00000010:  2E 30 31 20 28 31 31 31 31 34 31 29 00 00 00 00  | .01 (111141)....
> 00000020:  00 00 00 00 30 30 30 38 30 30 30 30 00 00 52 4F  | ....00080000..RO
> 00000030:  4D 20 42 41 53 45 20 32 2E 30 31 20 28 37 35 33  | M BASE 2.01 (753
> 00000040:  33 31 29 00 00 00 00 00 00 00 00 00 46 57 56 45  | 31).........FWVE
> 00000050:  52 3D 54 49 4D 20 31 2E 31 30 00 00 00 00 00 00  | R=TIM 1.10......
> 00000060:  00 00 00 00 00 00 00 00 00 00 50 52 4F 54 56 45  | ..........PROTVE
> 00000070:  52 3D 32 32 2E 30 30 00 00 00 00 00 00 00 00 00  | R=22.00.........
> 00000080:  00 00 00 00 00 00 00 00 4D 4F 44 3D 4C 45 41 2D  | ........MOD=LEA-
> 00000090:  4D 38 54 2D 30 00 00 00 00 00 00 00 00 00 00 00  | M8T-0...........
> 000000A0:  00 00 00 00 00 00 46 49 53 3D 30 78 45 46 34 30  | ......FIS=0xEF40
> 000000B0:  31 35 20 28 31 30 30 31 31 31 29 00 00 00 00 00  | 15 (100111).....
> 000000C0:  00 00 00 00 47 50 53 3B 47 4C 4F 3B 47 41 4C 3B  | ....GPS;GLO;GAL;
> 000000D0:  42 44 53 00 00 00 00 00 00 00 00 00 00 00 00 00  | BDS.............
> 000000E0:  00 00 53 42 41 53 3B 49 4D 45 53 3B 51 5A 53 53  | ..SBAS;IMES;QZSS
> 000000F0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
> 00000100:  01 3D                                            | .=.
> 
> As you can see it looks like the frame thats received on the 6.3.3 kernel is
> mangled?
> This same message is just being requested over and over again from the GPS
> unit.
> 
> The offset where the tears occur looks to be pretty similar between each poll
> request.
> Usually the 1 at the end of the (75331 is where the first tear occurs.
> 
> I'd appreciate some quidance in how to track this down as there appears to
> have been a reasonable amount of work done to this driver and the serial core
> between these two versions.

A few ideas:
- try without dma_rx_complete() calling p->dma->rx_dma(p)
- revert 90b8596ac46043e4a782d9111f5b285251b13756
- Try the revert in https://lore.kernel.org/all/316ab583-d217-a332-d161-8225b0cee227@redhat.com/2-0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.patch
  (for e8ffbb71f783 and f8d6e9d3ca5c)

But finding the culprit with git bisect would be the most helpful here.


-- 
 i.
--8323329-1647315239-1684836582=:3565--
