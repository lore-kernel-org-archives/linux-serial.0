Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F3C11F69
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84F061DC4
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhF2JtC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 05:49:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:52261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhF2JtC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 05:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624959989;
        bh=pJi/cacmFxQUcBSzaI74Np6aoW9gHWInkj3JLhS/FOs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UWlf/E90+onLxJXqRC7C3kUtQ02ifFUKQYCoJc08tMuLXc57QZI599BWsf+REtMYB
         oHgzjY516rzFE+r+iDWSXBRrhAM5sADlDmVeXCfebu/EfcE/e0/t6pzeDEx0HpmQWR
         g+vXfCbUctm9vH/u/YwJ0BS688jfuLeh0dPvsNJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([149.172.234.120]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1loz5i1bWN-00RJ9y; Tue, 29
 Jun 2021 11:46:29 +0200
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux@armlinux.org.uk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
 <YNSA1H0cFKiPUn6N@kroah.com> <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
 <db436292-4115-0755-57d8-d63986f84453@kernel.org>
 <trinity-163a08b4-6e39-4d15-bde2-815342f13fc4-1624620116191@3c-app-gmx-bs05>
 <a89dec92-e764-c833-bbeb-ba3d84381e78@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <5c249dfc-90a6-7724-e884-9516aaf829fb@gmx.de>
Date:   Tue, 29 Jun 2021 11:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a89dec92-e764-c833-bbeb-ba3d84381e78@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xYwhpQvRI0zDNO+iXqJG6m9MmmnEhNVZH1wKLAF+u21EhMPRiuf
 zC9A9QzUc1bB62/ex6qSRxOkMt2kJCIdQHYOz+7FoTkuOUa0MP0VN/NiBPvM4jd2xHhjs2D
 BQCDBpqt2hcJZDcA7MfMD4zU0x4FSsOZE/LI72hxHGGSekrbHoXfWaY6V51ejp/CH0YTxEl
 +z6RKrdtjbas3fhE44foQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:im11365hbSo=:k6+CMDJ9f97ZSxHRqHZbt3
 ogTizEMC798B5fGXqRW6vBrsRQKurgdXzTBM6eMi0gSXC2vJljAYJenX50xnB8YnkwKTPtUej
 DkQGIoknEkApVh6I3DQCwIF4NOzcidFe/lH2MEViOTUBadSbj+pvi7JepgH2y1iLaI35A2gyP
 lvExuoKS+20O9lPR7XLyxrPiFSR6gPn8QdyxmhLFVrTrqKm5uXS/503mYppWa4Z285FGUBxwC
 N3702FijmdEA5sdmetHGgGbH2VI1rvxtnOymEZjH938kMWtF7enaQybn3L9An8ZNK8MV8aJ7q
 ITUuC2AtdKnu6UYEzEfYban+hbrIGYTEqMt4uHIYXLNz4SxXhKbyLo4vOzugm70LRnDP4z9R9
 doPFAYUhKxLYDp1MWXpiTL83VjOTOL9Sqx7vVjT0qbhyMRHNWeW0+avU79ouBsIlP9rD+RZmB
 cAW3Hek2+fJdzdJVPLab8JgDHup+p1H1/7FVMumDkqmJYWBslmu1jXtdeZDO2Fu8F8GY4FvQQ
 3tpV90cxe3/qFtoTvbkonjQ7+xMF45f8Sb9PxNVZvi7qOtVrXurwzZaBlk3EK3zSxa6KtRlSH
 6zA9qaV9uw/HW09mj7RzITro5KenJM64TyTVLfTkZQwvKWe6tBV4ArnkqYAz3GWx520PqSb/t
 Q48uFEjI8RPBNvR7daqCbvb7LPYnT0biBo/GaHV21Aunq+NSb9WQ1i5DlcosI35EGy5z/0Jal
 ciHZA7D48Li+VeEWr2W/7O/baq1NzWTsNm1wAtsvL2pM6lpzIbiy+DOsQLMOhGx14sAP2N1pZ
 gZDUQcJdjuSeyNW5lxNpzI1OeoMPfr3Ub/kz1NWWtzqcjA4Wu+31eTZl5O/yW9RkbvVJbLScM
 hTVSkToWoYGIKc0MBT/JxeJFgFhCcXB2GMRYRK4Kyq4fsOnFxReiHZXA8YOzdHNReSbj1Ytqx
 ju2Cy6Vgs6VVZY5t5CTKQFj/2MNSonQmzRwj1qXxP0zPP8Dt8PjzrdAuek6iNmYmiW2uHGIom
 VqZon80ANYnHb+iFljt/yYmsRBKacLCGHZsXFBfsvhDxOQ3rSm4by97L4kc9i/wTjddHBYoid
 9PL8ONZfqKuiqwdRDs+vjPGb4StrH6JanE3nG3q/gAonHJKNi+Wbhi/Ag==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi,

On 26.06.21 at 05:41, Jiri Slaby wrote:

> On 25. 06. 21, 13:21, Lino Sanfilippo wrote:
>> Thats right, the logic has slightly changed. I thought this does not ma=
tter as long as
>> we make sure that exactly one of both ON_SEND or AFTER_SEND is set.
>
> I actually don't know. But I would remain consistent with other drivers.
>
>> We can stick with the logic
>> in serial8250_em485_config() (i.e. always set ON_SEND and delete AFTER_=
SEND in case
>> of an invalid setting), but I think this will require more than the fou=
r lines that we
>> have now (especially if we want to avoid the !!).
>
> What if you used only a single !?
>

You are right, this is the easiest way to keep the current logic. I will d=
o that.

Thanks,
Lino

