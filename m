Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABE5ECAAA1
	for <linux-serial@archiver.kernel.org>; Fri, 28 Oct 2022 06:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ1GUy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Oct 2022 02:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1GUx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Oct 2022 02:20:53 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5ECAC385;
        Thu, 27 Oct 2022 23:20:50 -0700 (PDT)
Date:   Fri, 28 Oct 2022 08:20:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1666938047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=F9MaZfC5dOvrw2AAE71aejLNXhOhHToAdH9Vvg4sUDQ=;
        b=gOsjlYKD35myIP4h5tqjz/IzS4BESg4AkjT7BR3Wl2VZXlLmfKWu3G2vNVUcQAlLrvg7P6
        k+hrwNmDUhKCVTXBw1NWH/gloJX0lKgQ3W0WUsZYIZJFqgmarofMLSoj9dbwrd6mR0Hjvg
        0F6MHvDBWlc4OPbgzgYdnYhNPkjD1DJ9ag4i7XjX1XhnaT6LUIamMG9TPUQkp6Xbp38+2N
        8CXC7+Hzcm6RnR3qgR/jHoZbE03fpIHoJ/J+V4HTX7frgU5UFMQ1KSmx3q1VHhUQ64joHV
        VmwaB9IwTpxrsffRG4p/h6GBBG60mn6TERs7R/bDEt8vDWZ13B9S3zvnNsm8jQ==
From:   Alexander Dahl <ada@thorsis.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marex@denx.de" <marex@denx.de>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Message-ID: <Y1t0vurzqh8XziDs@ada.ifak-system.com>
Mail-Followup-To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "marex@denx.de" <marex@denx.de>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
 <20221026165049.9541-2-cniedermaier@dh-electronics.com>
 <20221026205914.GA1294440-robh@kernel.org>
 <f04351971a5c4b5e8930000addb06398@dh-electronics.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04351971a5c4b5e8930000addb06398@dh-electronics.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Christoph,

let me first say, for an upcoming new product we are currently
developing, we tried different wirings, all related to that !RE pin of
the transceiver.

In a first hardware revision the engineer doing the schematic
connected !RE to GND (always on) and it took me a while to recognize
what was going on: everything send through TX was mirrored on RX,
which makes using lots of standard applications on that port just
fail.  (To be fair, we need exactly that behaviour on a different
board.)

In a second iteration !RE is directly connected to DE now, so RE is
now always the opposite of DE.  DE itself is always connected to the
RTS line of the UART, which allows the driver to switch direction.

More below.

Am Thu, Oct 27, 2022 at 12:06:56PM +0000 schrieb Christoph Niedermaier:
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, October 26, 2022 10:59 PM
> > On Wed, Oct 26, 2022 at 06:50:46PM +0200, Christoph Niedermaier wrote:
> >> Add the binding for a generic definition of a GPIO, that controls whether Rx
> >> is connected or disconnected by an electrical circuit to have the ability
> >> to receive the signals on the bus during sending or disable receiving during
> >> sending.
> >>
> >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >> ---
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: devicetree@vger.kernel.org
> >> To: linux-serial@vger.kernel.org
> >> To: linux-arm-kernel@lists.infradead.org
> >> ---
> >>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> >> index 90a1bab40f05..0ebd7690f85d 100644
> >> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> >> @@ -51,6 +51,10 @@ properties:
> >>      description: GPIO pin to enable RS485 bus termination.
> >>      maxItems: 1
> >>
> >> +  rs485-rx-during-tx-gpios:
> >> +    description: GPIO pin to control RS485 Rx enable during Tx.
> > 
> > Active state means do what? And inactive? This is an output gating the
> > RX signal or an input telling the receiver what to do during tx? The
> > description is not adequate.
> > 
> > How does this property relate to 'rs485-rx-during-tx' Any combination of
> > the 2 being present or not is okay? If not, you need some constraints.
> > 
> > Rob
> 
> 
> Hi Rob,
> 
> I have improved the message:
> 
> The standard RS485 is a half-duplex bus that in most cased is driven by an
> UART controller. The interface to the bus is controlled by a transceiver, that
> has a pin called RE (Rx enable) or similar, which connects the bus to Rx signal
> of the UART controller. This patch adds a binding for a generic definition of a
> GPIO that can switch between two states to control the RE pin via an electrical
> circuit:
> - Active:
>   The RE pin is always active. The UART Rx see everything on the bus and
>   therefore also what happens with the Tx signal on the bus.
> - Inactive:
>   The RE pin is always active, but during sending on the bus the pin RE is
>   inactive. So basically the receiving during sending is suppressed.
> 
> Is it now more understandable, or have I still not considered an aspect?

Better.  But what about the questions Rob asked?  There's already a
property 'rs485-rx-during-tx' which leads to setting the flag
SER_RS485_RX_DURING_TX in serial core.  As far as I understood from a
quick glance at core and drivers, this deals with half or full duplex
from the UART point of view (not the transceiver).

You need to explain, what's the difference to the new property.
I suspect you want to somehow switch behaviour with that GPIO line?
Which driver should switch that line in the end and when?

(For third iteration of our hardware we thought about a GPIO
controlling whether !RE is always on or connected to DE, but that's
probably not what you have in mind?)

Maybe a simple generic schematic could help explain or maybe you find
a better name for the property?

Greets
Alex

> 
> 
> Thanks and regards
> Christoph
