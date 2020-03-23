Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C80FC4332E
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625C620719
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584990114;
	bh=YRs4mrhPHXIMZTdf5p/iGgRJf9XseZ16wHVCMQiwstk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YApsI1nulPC1oYlljhApJIgUEyWvj6UQFR0NP0PM5mGwU2bLrEXuq3L8XS/dtyplO
	 tHh+s8fwiT03PeT7aHrrQD2aQi3tPaZXZ5IGA307A27fVivVVUpPqYSQWv2X36aY+z
	 aY+AujGVDgXEkUqpspkmP16LxSW+jKrgqNAm2rKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCWTBv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgCWTBv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 15:01:51 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3A320753;
        Mon, 23 Mar 2020 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584990110;
        bh=YRs4mrhPHXIMZTdf5p/iGgRJf9XseZ16wHVCMQiwstk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nSW9ZFATDzQa9L/ugTIBDmoYXyYF2+hjU1lnoDQcoHHREd11KSu00kwYGOKJqn4rP
         dZ2Po1tHBKPZYBJvdDGW0vzGbij1uSMqlyhhV6Y/yilfhsTqQnoUKNq0tnC8ypAsRl
         b9RzPvCoYHCkmQ+52eyfDyfc860fWyhwaiNXLwg8=
Received: by mail-qv1-f46.google.com with SMTP id v38so7811802qvf.6;
        Mon, 23 Mar 2020 12:01:50 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1B2/+Qz8dS4sjw1wLHre/RLxRSM64KFw9BLlIQUVIMM0Vr+vLC
        N1I1XBcBZpgFh6OT2isHbVbOBe3BkGh0jBISHg==
X-Google-Smtp-Source: ADFU+vtZfj3NsyyYYv7dL45XPEBZ0zGdtc3bidPipH2D4nR8TuLq0fULO/yXaatafS8cwmSLkV6OHdodvClaUapmViI=
X-Received: by 2002:a0c:f207:: with SMTP id h7mr3649102qvk.20.1584990109723;
 Mon, 23 Mar 2020 12:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200320174107.29406-1-lkundrak@v3.sk>
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Mar 2020 13:01:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+JSb3vgRusTu98VH9NVzrWDKEGiY0Rue9P9hUsgxLDgQ@mail.gmail.com>
Message-ID: <CAL_Jsq+JSb3vgRusTu98VH9NVzrWDKEGiY0Rue9P9hUsgxLDgQ@mail.gmail.com>
Subject: Re: [PATCH 0/10] NS 8250 UART Device Tree improvements
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 20, 2020 at 11:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi,
>
> this series aims to make it possible to validate NS 8250 compatible serial port
> nodes in Device Tree. It ultimately ends up converting the 8250.txt binding
> specification to YAML for json-schema.
>
> It starts by fixing up a couple of issues that would fail validation of
> device trees for various boards. Note there might be validation issues in other
> boards -- I don't have computing power to run "make dtbs_check" with
> CONFIG_OF_ALL_DTBS=y at the moment. I'm happy to fix up issues if somebody
> runs the test output to me.
>
> Unless someone has a different idea, I'd like to submit this to arm-soc once
> I get the Acks from PXA and Tango maintainers as well as DT reviewers:
>
>   [PATCH 01/10] ARM: dts: pxa*: Don't redeclare phandle references
>   [PATCH 02/10] ARM: dts: pxa*: Fix serial port names
>   [PATCH 03/10] ARM: dts: pxa*: Make the serial ports compatible with
>   [PATCH 04/10] ARM: dts: mmp2-brownstone: Don't redeclare phandle
>   [PATCH 05/10] ARM: dts: mmp*: Fix serial port names
>   [PATCH 06/10] ARM: dts: mmp*: Make the serial ports compatible with
>   [PATCH 07/10] ARM: dts: tango4: Make /serial compatible with ns16550a

For 1-7:

Reviewed-by: Rob Herring <robh@kernel.org>
