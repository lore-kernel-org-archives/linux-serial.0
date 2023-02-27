Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613EC64ED8
	for <linux-serial@archiver.kernel.org>; Mon, 27 Feb 2023 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjB0Wru (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 17:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjB0Wrs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 17:47:48 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888DC59EE
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 14:47:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so32431436edb.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 14:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RXLSQC7Iu4CGC+S5N03E14QHE8XVJvWIp6IPdBPR8k=;
        b=SXSmeX5N7YRzY/Riw5fOZdxkWfy/qLjp5eW9ruFC10w4FdOxLWxCF0zxJ5BaouNlTl
         pYkzLN2qZHAqqR3aC5pY/tCh75R4TBshWx2LiX4NMjuMM+WrFM5EeCUmkz3ng956gKhX
         nIq8wP2kT51eTydlhR3xaw6rC26SavejaCJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RXLSQC7Iu4CGC+S5N03E14QHE8XVJvWIp6IPdBPR8k=;
        b=KoB+j2iOSftlzfbn/GHPeowCf23dYSy7puIgCvGdmfj+YMBNOryfY+q7/K1j90Yqjc
         oS6KVz8lNcZMYk5yBvKHCdyAaggjWcA42iMgTZs7uB7anMvqsQVLTCQ3WhPsVu5VhohM
         xvmFYdJcgbAn4mHiMMx8qfXhtfizoqF+vg0l7Ri6pfJmyhiG3/6aGlGExsvAz3rLx0aJ
         Gr7X/n7GjwDBMIztOM2iwjMU37qNgwT96w/179YwSjtJ0kRjWzi9pvKM/zGEF3l973ty
         IlFTHMTMg4hQGQ7O77RS9isFlx9Tj9NwPX7LJOqX+QQrQZ2DgUfvaJKiwnn/anaFWAlm
         xhyw==
X-Gm-Message-State: AO0yUKVnhCsl+sVR0HFONfqzW+8PggWO133G4RvXLoWAkuW9nI1DVlt5
        o74IEp0unb9PI4qmvb81p9vaOoZZppLZxEiWWCw=
X-Google-Smtp-Source: AK7set9e2TH4y7m9qkZSmgDiu7tW4AiMuZ4yfBdo2R3EtSrbd5q7cLQe/XvxamSRyQ6kTjmMK+9+4w==
X-Received: by 2002:a17:906:2e82:b0:8b2:5262:562c with SMTP id o2-20020a1709062e8200b008b25262562cmr278975eji.34.1677538039696;
        Mon, 27 Feb 2023 14:47:19 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id fp2-20020a1709069e0200b008ee5356801dsm3739338ejc.187.2023.02.27.14.47.18
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 14:47:19 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id ec43so32266325edb.8
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 14:47:18 -0800 (PST)
X-Received: by 2002:a17:906:7c96:b0:878:561c:6665 with SMTP id
 w22-20020a1709067c9600b00878561c6665mr195508ejo.0.1677538038528; Mon, 27 Feb
 2023 14:47:18 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu> <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
 <Y/u59FFG+ID0OAbg@mit.edu> <Y/0vrqZjKcAnaZAH@smile.fi.intel.com>
In-Reply-To: <Y/0vrqZjKcAnaZAH@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 14:47:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj83jsF+4L9Sa2Cm3DutatL0xNhHYSvF3d_QZeekkGeWA@mail.gmail.com>
Message-ID: <CAHk-=wj83jsF+4L9Sa2Cm3DutatL0xNhHYSvF3d_QZeekkGeWA@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 27, 2023 at 2:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some of the "new" (not really, the split of the 8250_pci) drivers
> I made in the past inherited that so user won't see the change
> (sudden disappearance of the console w/o touching defconfig).

Ack. That's when 'default XYZ' should actually happen, in order to
people not miss old functionality that was split up into new config
options.

Which has definitely happened too. Then you spend an embarrassing
amount of time looking for "what broke for this device to not work",
when the answer was "that driver isn't built any more, even though the
config didn't change".

Ask me how I know.

         Linus
