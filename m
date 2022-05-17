Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FEC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 17 May 2022 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiEQStj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 May 2022 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352380AbiEQSti (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 May 2022 14:49:38 -0400
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 11:49:34 PDT
Received: from fas1.firebladeautomationsystems.uk (mail.firebladeautomationsystems.uk [3.11.73.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0604A922
        for <linux-serial@vger.kernel.org>; Tue, 17 May 2022 11:49:34 -0700 (PDT)
Received: from [192.168.1.37] (24.54.187.81.in-addr.arpa [81.187.54.24])
        by fas1.firebladeautomationsystems.uk (Postfix) with ESMTPSA id AAC24CA39D
        for <linux-serial@vger.kernel.org>; Tue, 17 May 2022 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=firebladeautomationsystems.uk; s=202202; t=1652812967;
        bh=dmhDT8ZFXI5L4kjq9lbIi1ilTJ4kF4SSnDfvUffbeM0=;
        h=Date:To:From:Subject:From;
        b=Xtxw6qo+zIaaYlQfY5Tnm498cpgrZRqmCCXxRXq1VMVeanMwnByKE7gyGmygB5w1p
         ZgufPueEVD9k6obOBvEfZwpb5g+acDt8htCwFp2cRcMynwOZX581c9brlqt1P8OFf4
         LWmh2KQm8EZtAqU0P9oH/8aWJnFKqt7a3dHiFwvXitV9uujoiFUNe4coSCqAVmhnbo
         OLl4aAH5cvgQXX4pnj09NzM3AS9jbeB1wEoD5C9dhvsuuR/551kIkWHls/hDuHVv0o
         08ruWz1X1vC1HTJerQRYzf/z5W7lpxOFne+6duq2PXzfkRAlTDoRzqmyKhcaXkwFia
         KZHdPUL1kS9mQ==
Message-ID: <341d8439-4466-7182-745d-ba613301e009@firebladeautomationsystems.uk>
Date:   Tue, 17 May 2022 19:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-GB
To:     linux-serial@vger.kernel.org
From:   linuxkernel <linuxkernel@firebladeautomationsystems.uk>
Subject: Using Serdev is it Possible to Pull RX Low
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

hello

I, looking at writing a kernel driver for the Texas instruments 
TPS92662A/TPS92663A

which uses a "UART bus" e.g

|-----------| |-----------| |-----------| |-----------| | | | TPS92662A 
| | TPS92662A | | TPS92663A | | UART | | -Q1 | | -Q1 | | -Q1 | | | | | | 
| | | |-----------| |-----------| |-----------| |-----------| | | | | | 
| | | | | | | 
-------------------------------------------------------------------
and control communications by specific sequencing.
configuring this appears to require being able to pull RX Low
> The MCU unit can reset the device UART and protocol state machine at 
> any time by holding the RX input low for a period of at least 12 bit 
> times (16 × 12 CLK periods). 
practically i can always pull RX low via other means, but if the UART 
can do this it would be better and be more generic.
is there a method of doing this via serdev or anything else? or will i 
likely have to resort to something like an additional GPIO pin to pull low
kind regards Christopher tyerman
