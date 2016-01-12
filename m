From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 00/11] Earlycon cleanup
Date: Tue, 12 Jan 2016 17:52:58 -0600
Message-ID: <CAL_JsqKmXtUg+QspirBQw80bh7GC4JnrUZojrY0-twzpE-xeVw@mail.gmail.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com> <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 12, 2016 at 1:41 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Greg, Grant & Rob,
>
> This patch series is a rebase of the v3 from April last year.
>
> This patch series builds on my earlier "Extensible console matching &
> direct earlycon" to add several useful features to earlycon:
> * Proper port i/o configuration from DT node with of_serial properties
>   (such as reg-io-width, reg-shift and reg-offset, and endianness)
> * Proper console name & index initialization from earlycon name
>   (for both command line and DT-defined earlycons)
> * Support for DT 'stdout-path' options pass-through to earlycon setup
> * Improved log messages for troubleshooting
> * Support for multiple OF earlycon declarations so different
>   compatible strings can specify the same OF earlycon
>
> * Changes from v3
>   - Added 32-bit big-endian support
>   - Removed the omap8250 earlycon (will follow later)
>
>
> Rob has expressed a desire to have the DT parts live in drivers/of/fdt.c
> The problem with this approach is two-fold. Firstly, the number of required
> parameters quickly becomes ugly (base address, io reg width, io reg offset,
> io reg stride, endianness, earlycon name). Secondly, drivers are already
> requiring access to alternate DT properties, like clocks, to initialize
> earlycons, and this requirement will continue.

I dislike ugliness more. So other than my one nit, for the series:

Acked-by: Rob Herring <robh@kernel.org>
