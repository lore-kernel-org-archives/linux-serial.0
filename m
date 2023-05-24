Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67BC77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjEXHwc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjEXHwb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 03:52:31 -0400
Received: from anchovy3.45ru.net.au (anchovy3.45ru.net.au [203.30.46.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26BE9E
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 00:52:28 -0700 (PDT)
Received: (qmail 9560 invoked by uid 5089); 24 May 2023 07:52:26 -0000
Received: by simscan 1.2.0 ppid: 9429, pid: 9430, t: 1.0412s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 24 May 2023 07:52:24 -0000
Message-ID: <261812cb-6de4-ec2b-18b0-90b5d9cc83e4@electromag.com.au>
Date:   Wed, 24 May 2023 15:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Possible regression in 8250_dw driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
 <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com>
From:   Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/05/2023 7:13 pm, Ilpo Järvinen wrote:

> On Tue, 23 May 2023, Richard Tresidder wrote:
>
>> Hi
>>     We seem to be getting corruption of received data from a ublox GPS unit
>> To me it looks like a fifo overrun of some sort??
> Overruns should be logged (in dmesg or /proc/tty/driver/serial).

Hmm wasn't seeing anything in either.

>
>> background:
>> I'm attempting to use 6.3.3 as a new base for one of our systems.
>> Previously it was using 5.1.7 as a base.
>> The uart in question is one of the two in the Cyclone V SOC HPS.
>> And to muddy the waters the linux console TTYS0 is the other Uart from the
>> same HPS core
>> Yet the console appears to be working ok.
> Maybe some of the DMA related changes triggering some unexpected behavior.
>
> Console doesn't use DMA so that could explain the difference.
>
>> Note all other libs and apps are at the same revision and build, it is only
>> the kernel that is different.
>> Both versions of the kernel are also built using the same bitbake bsdk..
>>
>> Seeing the following with 6.3.3:
>>
>>   00000000: 45 58 54 20 43 4F 52 45 20 33 2E 30 31 20 28 31  | EXT CORE 3.01 (1
>>   00000010: 31 31 31 34 31 29 00 00 00 00 00 00 00 00 30 30  | 11141)........00
>>   00000020: 30 38 30 30 30 30 00 00 52 4F 4D 20 42 41 53 45  | 080000..ROM BASE
>>   00000030: 20 32 2E 30 31 20 28 37 35 33 33 31 53 00 00 00  | 2.01 (75331S...
>>   00000040: 00 00 00 00 00 00 00 00 00 00 00 00 53 42 41 53  | ............SBAS
>>   00000050: 3B 49 4D 45 53 3B 51 5A 53 53 00 00 00 00 00 00  | ;IMES;QZSS......
>>   00000060: 00 00 00 00 00 00 00 00 00 00 01 3D 29 00 00 00  | ...........=)...
>>   00000070: 00 00 00 00 00 00 46 57 56 45 52 3D 54 49 4D 20  | ......FWVER=TIM
>>   00000080: 31 2E 31 30 00 00 00 00 00 00 00 00 00 00 00 00  | 1.10............
>>   00000090: 00 00 00 00 50 52 4F 54 56 45 52 3D 32 32 2E 30  | ....PROTVER=22.0
>>   000000a0: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | 0...............
>>   000000b0: 00 00 4D 4F 44 3D 4C 45 41 2D 4D 38 54 2D 30 00  | ..MOD=LEA-M8T-0.
>>   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
>>   000000d0: 46 49 53 3D 30 78 45 46 34 30 31 35 20 28 31 30  | FIS=0xEF4015 (10
>>   000000e0: 30 31 31 31 29 00 00 00 00 00 00 00 00 00 47 50  | 0111).........GP
>>   000000f0: 53 3B 47 4C 4F 3B 47 41 4C 3B 42 44 00 00 00 00  | S;GLO;GAL;BD....
>>   00000100: 00 00                                            | ..
>>
>> But should be seeing this as shown on 5.1.7:
>> Excuse the offset (due to this frame also showing the packet id's and lengths)
>> But the body of the frame is what we should be seeing.
>>
>> 00000000:  B5 62 0A 04 FA 00 45 58 54 20 43 4F 52 45 20 33  | µb..ú.EXT CORE 3
>> 00000010:  2E 30 31 20 28 31 31 31 31 34 31 29 00 00 00 00  | .01 (111141)....
>> 00000020:  00 00 00 00 30 30 30 38 30 30 30 30 00 00 52 4F  | ....00080000..RO
>> 00000030:  4D 20 42 41 53 45 20 32 2E 30 31 20 28 37 35 33  | M BASE 2.01 (753
>> 00000040:  33 31 29 00 00 00 00 00 00 00 00 00 46 57 56 45  | 31).........FWVE
>> 00000050:  52 3D 54 49 4D 20 31 2E 31 30 00 00 00 00 00 00  | R=TIM 1.10......
>> 00000060:  00 00 00 00 00 00 00 00 00 00 50 52 4F 54 56 45  | ..........PROTVE
>> 00000070:  52 3D 32 32 2E 30 30 00 00 00 00 00 00 00 00 00  | R=22.00.........
>> 00000080:  00 00 00 00 00 00 00 00 4D 4F 44 3D 4C 45 41 2D  | ........MOD=LEA-
>> 00000090:  4D 38 54 2D 30 00 00 00 00 00 00 00 00 00 00 00  | M8T-0...........
>> 000000A0:  00 00 00 00 00 00 46 49 53 3D 30 78 45 46 34 30  | ......FIS=0xEF40
>> 000000B0:  31 35 20 28 31 30 30 31 31 31 29 00 00 00 00 00  | 15 (100111).....
>> 000000C0:  00 00 00 00 47 50 53 3B 47 4C 4F 3B 47 41 4C 3B  | ....GPS;GLO;GAL;
>> 000000D0:  42 44 53 00 00 00 00 00 00 00 00 00 00 00 00 00  | BDS.............
>> 000000E0:  00 00 53 42 41 53 3B 49 4D 45 53 3B 51 5A 53 53  | ..SBAS;IMES;QZSS
>> 000000F0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
>> 00000100:  01 3D                                            | .=.
>>
>> As you can see it looks like the frame thats received on the 6.3.3 kernel is
>> mangled?
>> This same message is just being requested over and over again from the GPS
>> unit.
>>
>> The offset where the tears occur looks to be pretty similar between each poll
>> request.
>> Usually the 1 at the end of the (75331 is where the first tear occurs.
>>
>> I'd appreciate some quidance in how to track this down as there appears to
>> have been a reasonable amount of work done to this driver and the serial core
>> between these two versions.
> A few ideas:
> - try without dma_rx_complete() calling p->dma->rx_dma(p)
> - revert 90b8596ac46043e4a782d9111f5b285251b13756
> - Try the revert in https://lore.kernel.org/all/316ab583-d217-a332-d161-8225b0cee227@redhat.com/2-0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.patch
>    (for e8ffbb71f783 and f8d6e9d3ca5c)
>
> But finding the culprit with git bisect would be the most helpful here.
>
Bisect wasn't an easy option as I'd applied a pile of patches after the interesting commits for our system to run.
I'm not a git master :)

So I just started reverting the patches that had been applied to the 8250 folder.
Worked backwards from head.

After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
serial: 8250_dma: Fix DMA Rx rearm race

Things started to work again.

I reset everything and then just reverted that individual patch and things work.
So that looks like the culprit..

