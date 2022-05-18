Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BFFC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 18:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiERSLn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiERSLm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 14:11:42 -0400
X-Greylist: delayed 84532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 11:11:41 PDT
Received: from fas1.firebladeautomationsystems.uk (unknown [IPv6:2a05:d01c:f10:9d00:62c4:2d7b:a0b1:ef24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42F396B4
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 11:11:41 -0700 (PDT)
Received: from [192.168.1.37] (24.54.187.81.in-addr.arpa [81.187.54.24])
        by fas1.firebladeautomationsystems.uk (Postfix) with ESMTPSA id 3E03CCB1CC;
        Wed, 18 May 2022 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=firebladeautomationsystems.uk; s=202202; t=1652897500;
        bh=dJudHNHcmlivU7Mg1bUvYo/bQfAhWIib1JtphKG02tA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c/M9tIERyW828XoZkyjmQlTR2OYpHWe3qXVrnsMhZBLjZlisz7O7Dc2iKpDAnkF+t
         AIBRM0sZfwqU6yV8IexovreiGn258upzcXUCMhia7HR1Fo+0VjBe5s4BNzzfjCpCGR
         soRO4VxwI5TfrTxuLTwJJ8hNOX604PuLiZg8MdJftA5ed6wmsgJcq3nh+2v5mXmWUE
         sclE5Tygi2vWrgkAo3ColIiKNazj8Thq16Qz+XbL0CH0XayA3C/DBgZd/1KklJZwjK
         GDWmPWQf8VZqpOq0j9M1DzKXFpHEu95DLtYPnvhkaq2lAa/M+EvihmxWviRFFfbtcB
         DE0nMDFHSSjmQ==
Message-ID: <e92ad3ac-3d52-7f77-8839-74ef81a74154@firebladeautomationsystems.uk>
Date:   Wed, 18 May 2022 19:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Using Serdev is it Possible to Pull RX Low
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <341d8439-4466-7182-745d-ba613301e009@firebladeautomationsystems.uk>
 <YoSy2vnS68wkLpcO@kroah.com>
From:   christopher tyerman <linuxkernel@firebladeautomationsystems.uk>
In-Reply-To: <YoSy2vnS68wkLpcO@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/05/2022 09:48, Greg KH wrote:> On Tue, May 17, 2022 at 07:42:46PM 
+0100, linuxkernel wrote:
 >> hello I, looking at writing a kernel driver for the Texas instruments
 >> TPS92662A/TPS92663A which uses a "UART bus" e.g
 >> |-----------|    |-----------|    |-----------|     |-----------|
 >> |           |    | TPS92662A |    | TPS92662A |     | TPS92663A |
 >> |   UART    |    | -Q1       |    | -Q1       |     | -Q1 	   |
 >> |           |    |           |    |           |     |           |
 >> |-----------|    |-----------|    |-----------|     |-----------|
 >>       |                |                |                 |
 >>       |                |                |                 |
 >>       |                |                |                 |
 >>       -----------------------------------------------------
 >> and control communications by specific sequencing. configuring this
 >> appears to require being able to pull RX Low
 >>> The MCU unit can reset the device UART and protocol state machine at
 >>> any time by holding the RX input low for a period of at least 12 bit
 >>> times (16 × 12 CLK periods).
 >> practically i can always pull RX low via other means, but if the UART
 >> can do this it would be better and be more generic.
 > How can your UART do that in a generic way? thanks, greg k-h sorry

im not sure i explained that clearly

i also appear to have, not got the previous diagram right, (corrected in 
this reply for clarity) Im still getting used to plain text emails.

im not that familiar with UARTs in practice, and after re-reading i 
think i could have phrased that better, as had issue with MCU/IC UART 
TX/RX perspectives

e.g

|-----------|           |-----------|
|         TX|-----------|RX         |
| MCU UART  |           |    IC     |
|         RX|-----------|TX         |
|-----------|           |-----------|

from the mcu perspective its the TX pin, while from the RX pin from the 
ICs perspective.

from that perspective i need to pull the ICs RX pin low which means pull 
the MCU UART TX pin Low.

now this seems conceptually similar to a "break condition"

which some tty functions can produce
e.g
static int send_break(struct tty_struct *tty, unsigned int duration) 
[https://elixir.bootlin.com/linux/latest/source/drivers tty/tty_io.c#L2461]

with which i might me half way to answering my own question

i can't see call to that via serdev, or equivalent


however the serdev code sits on top of the tty code 
(http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf#Outline0.11)

it appears i would have to somehow get to the underlying send_break() 
function without breaking anything

which needs a vaild tty_struct which appears to be part of tty_port and 
can get via

struct tty_struct *tty_port_tty_get(struct tty_port *port);

and it appears that you can get that via

struct serport *serport = serdev_controller_get_drvdata(ctrl);

and can get struct serdev_controller *ctrl from struct serdev_device


but doing that cleanly is another thing.


i could either try and write something like that into the driver or 
could try and write a patch for serdev that effectively calls that 
function in tty so a serdev device can request a break from itself

unless there is a alternative im not seeing.

if there is any advice you can give that would be helpful


kind regards

christopher tyerman

































