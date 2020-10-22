Return-Path: <SRS0=OWvP=D5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF9BC388F2
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75979222E9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 07:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508301AbgJVHRO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:17:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395378AbgJVHRO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 03:17:14 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MofLl-1k2iSo3WcT-00p2qj; Thu, 22 Oct 2020 09:16:52 +0200
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Brad Boyer <brad@allandria.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
 <20201020173745.GA882703@kroah.com>
 <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
 <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
 <20201020224446.GA15066@allandria.com>
 <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet>
 <311d17ed-75fa-a7fe-6c70-177a6eec4519@vivier.eu>
 <alpine.LNX.2.23.453.2010221347000.6@nippy.intranet>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <8407af95-09a0-bc94-68c6-60dc79756fec@vivier.eu>
Date:   Thu, 22 Oct 2020 09:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2010221347000.6@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kR5ZXkM+otLzHr0F7yxO98XVjqzMmM9yrqfG0X7H/0I8db+z0Nf
 nNo06sUMiGOpn58MeHxhrqVwkmVx6tcMYORxakhwqwxkRN5V/Rzrf0TJdMnUYW49rw9Evaa
 oNRc4popjb+W3MHCV0NzjNtjGnBIWiJg/pLF0ji/hQnm2jbg+InWTDrOpR13PargkM0G8/+
 GXwB/CH8YkrAGLt1jkRsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qJ9oo3n2EM0=:UPZcRJOj3+jD2O8p56GulX
 MekodAzerhAkAXQyuH4u6lJEeyPGesc/YQkW0iDL2Qd42mWfY60dXAhrwzOKqBEwpK/EIMLOd
 N4Wt8KMxVRKb6RScCbHPGrLvhZ7cd6+eoXp1HiVL/3Vf3tEqkQ5HwFh3DikpVD3gR3cP5QMrl
 E4Yj4FMhlkbgdOee5uepXeMyQ3k5+4brpgQpqc7Jlb/JlUfq7XyKU/Amj8GFc4IohO70oddrp
 /f2koVWAA3tqm+qr9oZf26mw98J5CjbzlEWSqK/qGm1uoDYec76kU3ilvdy9UBm6kcpGuwIdQ
 Bx8w53+K6DDdq7SH478Ci/HZCWrKUt5G2i8GdagkecqA4mzDPRIq+29nKGzewGtps/cpaZJcg
 0L0n4L4I4zG+zPNEXeTQDNpL18SIfVU39LhlkY7DJZh49UHNvSFtlIzgX24qA
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 22/10/2020 à 05:23, Finn Thain a écrit :
> On Wed, 21 Oct 2020, Laurent Vivier wrote:
> 
>> Le 21/10/2020 à 01:43, Finn Thain a écrit :
>>
>>> Laurent, can we avoid the irq == 0 warning splat like this?
>>>
>>> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
>>> index 96e7aa479961..7db600cd8cc7 100644
>>> --- a/drivers/tty/serial/pmac_zilog.c
>>> +++ b/drivers/tty/serial/pmac_zilog.c
>>> @@ -1701,8 +1701,10 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
>>>  	int irq;
>>>  
>>>  	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
>>> +	if (!r_ports)
>>> +		return -ENODEV;
>>>  	irq = platform_get_irq(uap->pdev, 0);
>>> -	if (!r_ports || irq <= 0)
>>> +	if (irq <= 0)
>>>  		return -ENODEV;
>>>  
>>>  	uap->port.mapbase  = r_ports->start;
>>>
>>
>> No, this doesn't fix the problem.
>>
> 
> Then I had better stop guessing and start up Aranym...
> 
> The patch below seems to fix the problem for me. Does it work on your 
> system(s)?

It works like a charm.

Thank you,
Laurent
