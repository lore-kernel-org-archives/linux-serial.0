From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 16:14:02 +0100
Message-ID: <20120921161402.25cf1520@pyramind.ukuu.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christophe Arnal <christophe.arnal@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

> So I looked closer: uart_get_baud_rate() in turn calls out to
> tty_termios_baud_rate() which does some fuzzy matching to the
> fix baudrate table and simply "snaps" the baudrate to the closest
> match if it is "close enough".

The fuzzing is getting done when re-encoding and because the code
encodes/re-decodes stuff.

> I wonder how to fix this ... I'm planning to do what the comment
> in tty_ioctl says:

If you support the ancient alt speed hacks then its not quite so neat.

Alan
