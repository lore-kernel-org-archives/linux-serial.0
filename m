Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F742C2B9F4
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A4F613BA
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 17:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhFQRqg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:46:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:45679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFQRqg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Jun 2021 13:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623951861;
        bh=p7yOt8Sqqwg0+64uhl7jjD3EXyo9D1HBcssfQqYQmQ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fUdcjcjInBNGszsPGx2vM+W7ZQ4HnqdSALwJUCE1bW1RucH6ycINfiDX7tYmrx2/R
         wM6yENoXKrcBR17tOmNhkqN+eCmnxBpk6fcv7/Qr+uYirYUuNVWZjjJLxsOqDhK29J
         BScqaw762H9hygIR6hhzc5bpJImzaOMWI4Y/Vh2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([149.172.234.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1l4jJn32j4-00y5O9; Thu, 17
 Jun 2021 19:44:21 +0200
Subject: Re: [PATCH] serial: amba-pl011: add RS485 support
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210610135004.7585-1-LinoSanfilippo@gmx.de>
 <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <7c0ac56d-58da-5e8a-b6be-44bafb183443@gmx.de>
Date:   Thu, 17 Jun 2021 19:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jh2NaU0qBdY0oHOTZ9WDd6NQuapDUwCMl8vXx7fGOIXDeDQF0rq
 ZU5J8Eu2cn31J/RlaguLdKG+oDDiSz+SKeRAG91C8jw/PadL6O0uFox1B6wVal/nDHwbLWQ
 a9hrrKQWeKya7kMRZ+uxIJWLqetztQMQ6lb9H8kmo/e4SmomSjI3GBOrFSdLUvdwGtCg0ps
 i1MBTThGM0rmCLxzCFTew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XxZZ6/QTf7Q=:VkhEKu0XfIC0jNxdeQ3/Vi
 lmElive9Cbl1xYCRlOJhK55b4jdqAIUVwmHNsLucsdxKZwV7QWiBbbcuerLYJntaDbXOEKQpD
 WOgVdlCYU4yX1xInBGfG1hxftu0jBLAV4dreKPWL8GAIPnb+RNSah6v0+AoL7uumZDwG5yNoC
 yKXl7caqguB3/rg+B+3gWtgVP6s4ntPMmUaSqh2BY3kQdr1vHHdpsJMN7XuxJGOkD72zmNpi2
 ihS9tNIGhpPoBHzEsusFbMiEE6U/ZvtKazYXMOu4ZUq3o0oPb9PzgogfADKXCDIXUDs7zUxxs
 rzbFPk7kmOhNNBOp6Z1JTfoCjM/wnwSVzPNkEknMqGmT9+1XQT5mLo6IvOWcCV/3RxUjBSrM7
 9fz2U6BtvTAINormfUoAdZmN2ssQe+TPgj0nWJ97HSLR843baTgtFVCLQiYy96dRq13LmwYZu
 VbTMIZm99XbMzqSgwLhbPAq/GdmvevtbGBrts1IQPNAaAKxo87bB7j++7WnaNkrHmJuF+Cs+1
 6+7MvPzhsgxnlbCxc2AHvOZ74y8NLnRWjnFEVg8bUVZCydqGIDoeHKyhKexDbjovQdy0QLV5d
 ka2BsjlAo4CwLZfagv2AMUJQIfDCPvfW4YKG3BBnkS10Klxt+RKbq1bChozB5lwEZxM0MYbzE
 C6cl3x8ggBCbDVzoD8oq1aWXNqBpw0j9zZw4fmR8VrXLOGeHgtIO+6clxD6w7Xuectn+auIz0
 nxw1HsCCNqt7NxXHLqvL2+GXsjV4IvcgoQZx+XsRMYUgsWrk5a5/nzzGcZ9ecU48+fxOBsxYl
 dcchrKU4csaIFMblT65v85WzmlpK0a6ZjuZGEOquhLym0v2BDDuyEmey+Fvm6DvDQhSGm6n0g
 PuxnUOvcH0k5YUcUDvEOdo1Bw51MzEZ6xtHGPJ1TjxFlP+skL0TwoH7+ZdTqSSFfMWZ/CwgG8
 gEmoVSMLZ5rlbiYl1gIpZ7fniPCMm3TQTHd6Hruc+mHTs3bzLhGgmrprNLdD0TR3Bfs92C2Rz
 Rx7GHnTxNLK0g5QcBJ23w4q7uyzIQkWHBC6QJqHLBwCmFxGfB/FNbFLKVs9h4swRzXLfZk8R2
 BEWY7DgdM7WYGUQFBWOLeIULPiQAzCbLM6IqBwNW3B0G7qbViky0vmUXw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi,

On 16.06.21 at 08:18, Jiri Slaby wrote:
=A0=A0=A0=A0=A0=A0=A0 mdelay(port->rs485.delay_rts_before_send);
>
> This is up to 1 second delay with interrupts disabled. Definitely not ni=
ce. 8250 clamps this to 100 ms at least, why did you choose 1000 ms?
>

AFAICS the 8250 driver does not clamp values read from the device tree pro=
perty "rs485-rts-delay"
(set by uart_get_rs485_mode()). Is this on purpose?

Regards,
Lino
