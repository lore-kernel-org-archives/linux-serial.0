Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D0C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265E5610FC
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhI0UrH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236741AbhI0UrF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 16:47:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8174610A2;
        Mon, 27 Sep 2021 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632775526;
        bh=KjKkP19ege6f7VD3cv62K8iH7hKJgu0j2zznaeGU89A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwJ8GGLI/f5JOrrlzS4GyDp88W5sx14FMD53GLS2cHlkAaJQxkj8dJQVOpCQvsIr2
         uurN5SXoFxRm4iYGeX6vvRmBVCDlF1CDMGUhcRieAiz1tRi/G41ZtOReWq2hJc9dJ1
         IEllt/gEo4qrOJFqTDlJR9GN3fVlI5KEjRQnYg3V0wQjaOyJjWK2WxphTucnuxYrKB
         89FT+EPW8SSW2zr7/BIOpAnAxk3VP+KGfdLvdg1bqPWkMEpAIO/9N+7d3J9hI9nehn
         XkoKhgb1icLEK7mhAGPxtw4BCSRr/x4JDO8tSvBTMAiWt9ofNJbf3D/jZesjghTIv3
         b3ysjJohdc1Yg==
Received: by pali.im (Postfix)
        id 3E182C83; Mon, 27 Sep 2021 22:45:24 +0200 (CEST)
Date:   Mon, 27 Sep 2021 22:45:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v5 3/6] dt-bindings: mvebu-uart: document DT
 bindings for marvell,armada-3700-uart-clock
Message-ID: <20210927204524.giaormuph3vcy4ls@pali>
References: <20210922105433.11744-1-pali@kernel.org>
 <20210922105433.11744-4-pali@kernel.org>
 <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Monday 27 September 2021 15:17:59 Rob Herring wrote:
> On Wed, Sep 22, 2021 at 5:56 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > This change adds DT bindings documentation for device nodes with compatible
> > string "marvell,armada-3700-uart-clock".
> 
> Please resend to the DT list so that checks run and this gets reviewed
> in a timely manner.
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > new file mode 100644
> > index 000000000000..5bdb23e0ba3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license. checkpatch will tell you which ones.

Did not tell me :-(

$ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
total: 0 errors, 0 warnings, 57 lines checked

Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no obvious style problems and is ready for submission.

Huh, Perl needs Python?? Anyway...

$ sudo apt install python3-ply
...

$ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 10, in <module>
    import git
ModuleNotFoundError: No module named 'git'
total: 0 errors, 0 warnings, 57 lines checked

Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no obvious style problems and is ready for submission.

Second attempt...

$ sudo apt install python3-git
...

$ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
total: 0 errors, 0 warnings, 57 lines checked

Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no obvious style problems and is ready for submission.

And no error :-(
