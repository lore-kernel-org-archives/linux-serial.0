From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] tty: serial_core: Move uart_console() check after
 console registration
Date: Mon, 3 Oct 2016 21:42:25 +0200
Message-ID: <CAMuHMdXzqW2FfYKwBGevBCbA5f4m7+p+hGF7XJpppDz=VNMs1w@mail.gmail.com>
References: <1475163064-20399-1-git-send-email-geert+renesas@glider.be> <CAL_JsqK9JL6UmCzi-szPSakVNp1Cv4-ZVrGnrQ6hdKt_8VJQSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK9JL6UmCzi-szPSakVNp1Cv4-ZVrGnrQ6hdKt_8VJQSQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Mon, Oct 3, 2016 at 8:25 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Sep 29, 2016 at 10:31 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> The port->console flag is always false, as uart_console() is called
>> before the serial console has been registered.
>
> I'm not seeing how that is. Everything uart_console() depends on
> (port->cons, port->cons->index, and port->line) should be set already.
> Maybe you pass in -1 for index which gets changed to 0 is the only
> thing I can see. Is doing that valid if you have multiple ports?

Isn't .index always initialized to -1, and set to the actual line number wh=
en
the console is registered? That's how I remember it from when
register_console() was introduced (in 2.1)...

>> Hence for a serial port used as the console, uart_tty_port_shutdown()
>> will still be called when userspace closes the port, powering it down.
>> This will lead to a system lock up when the serial console driver writes
>> to the serial port's registers.
>>
>> To fix this, move the setting of port->console after the call to
>> uart_configure_port(), which registers the serial console.
>>
>> Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tt=
y_port_close")
>> Reported-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.s=
e>
>> Reported-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> RFC because of the comment "If this port is a console, then the spinlock
>> is already initialised", and the pre-existing code calling
>> uart_console() before uart_configure_port().
>
> So the spinlock is initialized twice which is probably harmless? If
> the spinlock was initialized by the console, then the index would
> probably not be -1.

Shouldn't a double initialization cause a warning, with DEBUG_SPINLOCK=3Dy
(which I have enabled)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
