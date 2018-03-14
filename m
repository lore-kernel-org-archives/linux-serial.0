From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 11:53:43 +0100
Message-ID: <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-2-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Douglas Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Daniel


On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> input clock.
>
> Allow these platforms to set up this clock by specifying a kernel command
> line like:
> earlycon=amdcz,mmio32,0xfedc6000,115200


If the port and the mode (mmio32) is always fixed, couldn't we just
add those two into
early_amdcz_setup?


Thanks!
