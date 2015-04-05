From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v4] earlycon: 8250: Fix command line regression
Date: Sun, 5 Apr 2015 00:09:44 -0700
Message-ID: <CAE9FiQXhbR-g0SPeZ=CPGXuRGk0KrdpvaPXK_JDgg58OGk0EbA@mail.gmail.com>
References: <1428157650-16418-1-git-send-email-peter@hurleysoftware.com>
	<1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf304275beba9b850512f4dd35
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

--20cf304275beba9b850512f4dd35
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 4, 2015 at 10:19 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
...
>  Documentation/kernel-parameters.txt  | 18 +++++++++++++++---
>  drivers/tty/serial/8250/8250_core.c  | 37 +++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/8250/8250_early.c | 19 ------------------
>  3 files changed, 49 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index bfcb1a6..1facf0b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -713,10 +713,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>
>                 uart[8250],io,<addr>[,options]
>                 uart[8250],mmio,<addr>[,options]
> +               uart[8250],mmio32,<addr>[,options]
> +               uart[8250],0x<addr>[,options]

put this to other patch please.

>                         Start an early, polled-mode console on the 8250/16550
>                         UART at the specified I/O port or MMIO address,
> -                       switching to the matching ttyS device later.  The
> -                       options are the same as for ttyS, above.
> +                       switching to the matching ttyS device later.
> +                       MMIO inter-register address stride is either 8-bit
> +                       (mmio) or 32-bit (mmio32).
> +                       If none of [io|mmio|mmio32], <addr> is assumed to be
> +                       equivalent to 'mmio'. 'options' are specified in the
> +                       same format described for ttyS above; if unspecified,
> +                       the h/w is not re-initialized.
> +
>                 hvc<n>  Use the hypervisor console device <n>. This is for
>                         both Xen and PowerPC hypervisors.
>
> @@ -944,11 +952,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                 uart[8250],io,<addr>[,options]
>                 uart[8250],mmio,<addr>[,options]
>                 uart[8250],mmio32,<addr>[,options]
> +               uart[8250],0x<addr>[,options]

and this to another patch please.

>                         Start an early, polled-mode console on the 8250/16550
>                         UART at the specified I/O port or MMIO address.
>                         MMIO inter-register address stride is either 8-bit
>                         (mmio) or 32-bit (mmio32).
> -                       The options are the same as for ttyS, above.
> +                       If none of [io|mmio|mmio32], <addr> is assumed to be
> +                       equivalent to 'mmio'. 'options' are specified in the
> +                       same format described for "console=ttyS<n>"; if
> +                       unspecified, the h/w is not initialized.
>
>                 pl011,<addr>
>                         Start an early, polled-mode console on a pl011 serial
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e0fb5f0..456606f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -3447,6 +3447,21 @@ static int univ8250_console_setup(struct console *co, char *options)
>         return serial8250_console_setup(up, options);
>  }
>
> +static unsigned int probe_baud(struct uart_port *port)
> +{
> +       unsigned char lcr, dll, dlm;
> +       unsigned int quot;
> +
> +       lcr = serial_port_in(port, UART_LCR);
> +       serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
> +       dll = serial_port_in(port, UART_DLL);
> +       dlm = serial_port_in(port, UART_DLM);
> +       serial_port_out(port, UART_LCR, lcr);
> +
> +       quot = (dlm << 8) | dll;
> +       return (port->uartclk / 16) / quot;
> +}
> +

You said some "newer" chips do not support probe baud. why do you move
code to core ?

I was thinking some embedded guys could comment out 8280_early.c, now you get
extra work for them to comment out code from 8250_core.c.

>  /**
>   *     univ8250_console_match - non-standard console matching
>   *     @co:      registering console
> @@ -3455,13 +3470,18 @@ static int univ8250_console_setup(struct console *co, char *options)
>   *     @options: ptr to option string from console command line
>   *
>   *     Only attempts to match console command lines of the form:
> - *         console=uart<>,io|mmio|mmio32,<addr>,<options>
> - *         console=uart<>,<addr>,options
> + *         console=uart[8250],io|mmio|mmio32,<addr>[,<options>]
> + *         console=uart[8250],0x<addr>[,<options>]
>   *     This form is used to register an initial earlycon boot console and
>   *     replace it with the serial8250_console at 8250 driver init.
>   *
>   *     Performs console setup for a match (as required by interface)
>   *
> + *     ** HACK ALERT **

That is not HACK original.

but your fix make it to be hack.

> + *     If no <options> are specified, then assume the h/w is already setup.
> + *     This was the undocumented behavior of the original implementation so
> + *     it is cast in stone forever.
> + *
>   *     Returns 0 if console matches; otherwise non-zero to use default matching
>   */
>  static int univ8250_console_match(struct console *co, char *name, int idx,
> @@ -3475,12 +3495,16 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>         if (strncmp(name, match, 4) != 0)
>                 return -ENODEV;
>
> +       if (idx && idx != 8250)
> +               return -ENODEV;
> +

Your fix is getting ugly now.

>         if (uart_parse_earlycon(options, &iotype, &addr, &options))
>                 return -ENODEV;
>
>         /* try to match the port specified on the command line */
>         for (i = 0; i < nr_uarts; i++) {
>                 struct uart_port *port = &serial8250_ports[i].port;
> +               int baud, bits = 8, parity = 'n', flow = 'n';
>
>                 if (port->iotype != iotype)
>                         continue;
> @@ -3490,8 +3514,15 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>                 if (iotype == UPIO_PORT && port->iobase != addr)
>                         continue;
>
> +               /* link port to console */
>                 co->index = i;
> -               return univ8250_console_setup(co, options);
> +               port->cons = co;
> +
> +               if (options && *options)
> +                       uart_parse_options(options, &baud, &parity, &bits, &flow);
> +               else
> +                       baud = probe_baud(port);
> +               return uart_set_options(port, port->cons, baud, parity, bits, flow);

what a mess.

Now sure if it is safe to move down probe_baud, when serial port is still used.

>         }
>
>         return -ENODEV;
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index e95ebfe..8e11968 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -105,21 +105,6 @@ static void __init early_serial8250_write(struct console *console,
>                 serial8250_early_out(port, UART_IER, ier);
>  }
>
> -static unsigned int __init probe_baud(struct uart_port *port)
> -{
> -       unsigned char lcr, dll, dlm;
> -       unsigned int quot;
> -
> -       lcr = serial8250_early_in(port, UART_LCR);
> -       serial8250_early_out(port, UART_LCR, lcr | UART_LCR_DLAB);
> -       dll = serial8250_early_in(port, UART_DLL);
> -       dlm = serial8250_early_in(port, UART_DLM);
> -       serial8250_early_out(port, UART_LCR, lcr);
> -
> -       quot = (dlm << 8) | dll;
> -       return (port->uartclk / 16) / quot;
> -}
> -
>  static void __init init_port(struct earlycon_device *device)
>  {
>         struct uart_port *port = &device->port;
> @@ -151,10 +136,6 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
>                 struct uart_port *port = &device->port;
>                 unsigned int ier;
>
> -               device->baud = probe_baud(&device->port);
> -               snprintf(device->options, sizeof(device->options), "%u",
> -                        device->baud);
> -
>                 /* assume the device was initialized, only mask interrupts */
>                 ier = serial8250_early_in(port, UART_IER);
>                 serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
> --

Greg, Please consider apply my fix as attached, it is much cleaner.

Or just drop commit c7cef0a84912 ("console: Add extensible console matching")
from the tty-next now.

Thanks

Yinghai

--20cf304275beba9b850512f4dd35
Content-Type: text/x-patch; charset=US-ASCII; name="fix_earlycon_console_handover_v3.patch"
Content-Disposition: attachment;
	filename="fix_earlycon_console_handover_v3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i83zdz0z0

U3ViamVjdDogW1BBVENIIC12M10gZWFybHljb246IEZpeCBlYXJseWNvbi9jb25zb2xlIGhhbmRv
dmVyIHdpdGhvdXQgb3B0aW9ucwoKY29tbWl0IGM3Y2VmMGE4NDkxMiAoImNvbnNvbGU6IEFkZCBl
eHRlbnNpYmxlIGNvbnNvbGUgbWF0Y2hpbmciKQpicm9rZSB0aGUgZWFybHljb24vaGFuZG92ZXIg
d2hlbiBib290aW5nCmNvbnNvbGU9dWFydDgyNTAsaW8sMHgzZjgKCnRoZSBib290bG9hZGVyIGlz
IHVzaW5nIDExNTIwMCwgYW5kIHRoZSBlYXJseWNvbiBjb250aW51ZQp1c2UgMTE1MjAwLCBidXQg
Y29uc29sZSByZXZlcnQgYmFjayB0byA5NjAwLgoKQmVmb3JlIHRoZSBjb21taXQsIHByb2JlZCBi
YXVkIHJhdGUgaXMgcGFzc2VkIHZpYSBjb25zb2xlX2NtZGxpbmUKZnJvbSBlYXJseWNvbiB0byBu
b3JtYWwgY29uc29sZS4KVGhhdCBjb21taXQgcmVtb3ZlIHRoYXQgYW5kIG9ubHkgY2hlY2sgYm9v
dCBjb21tYW5kIGxpbmUuCgpUaGlzIHBhdGNoIHVzZSBwb3J0IG1hdGNoIHRvIGdldCBob2xkIGVh
cmx5Y29uLCBhbmQgdXNlIGVhcmx5Y29uCmRldmljZSBvcHRpb25zIHRvIHVwZGF0ZSBvcHRpb25z
IGZvciBjb25zb2xlLgoKV2l0aCB0aGF0IHdlIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJlaGF2aW9y
LgoKRml4ZXM6IGNvbW1pdCBjN2NlZjBhODQ5MTIgKCJjb25zb2xlOiBBZGQgZXh0ZW5zaWJsZSBj
b25zb2xlIG1hdGNoaW5nIikKU2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJu
ZWwub3JnPgoKLS0tCi12Mjogc2ltcGxpZnkgc2VyaWFsODI1MF9nZXRfZWFybHljb25fb3B0aW9u
cyBhbmQgZG9uJ3QgdXBkYXRlCiAgICAgY29uc29sZV9jbWRsaW5lLgotdjM6IGFkZCBlYXJseWNv
bl9tYXRjaCB0byByZXN0b3JlIG9yaWdpbmFsIGJlaGF2aW9yLgotLS0KCi0tLQogZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9jb3JlLmMgIHwgICAgMyArKysKIGRyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfZWFybHkuYyB8ICAgIDcgKysrKysrKwogZHJpdmVycy90dHkvc2VyaWFsL2Vh
cmx5Y29uLmMgICAgICAgIHwgICAxNSArKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvc2Vy
aWFsX2NvcmUuaCAgICAgICAgICB8ICAgIDIgKysKIDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2Nv
cmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX2NvcmUuYworKysgbGludXgtMi42L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBf
Y29yZS5jCkBAIC0zNDkwLDYgKzM0OTAsOSBAQCBzdGF0aWMgaW50IHVuaXY4MjUwX2NvbnNvbGVf
bWF0Y2goc3RydWN0CiAJCWlmIChpb3R5cGUgPT0gVVBJT19QT1JUICYmIHBvcnQtPmlvYmFzZSAh
PSBhZGRyKQogCQkJY29udGludWU7CiAKKwkJaWYgKCFlYXJseWNvbl9tYXRjaChwb3J0LCAmb3B0
aW9ucykpCisJCQlyZXR1cm4gLUVOT0RFVjsKKwogCQljby0+aW5kZXggPSBpOwogCQlyZXR1cm4g
dW5pdjgyNTBfY29uc29sZV9zZXR1cChjbywgb3B0aW9ucyk7CiAJfQpJbmRleDogbGludXgtMi42
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZWFybHkuYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51
eC0yLjYub3JpZy9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2Vhcmx5LmMKKysrIGxpbnV4
LTIuNi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2Vhcmx5LmMKQEAgLTEwNSw2ICsxMDUs
MTIgQEAgc3RhdGljIHZvaWQgX19pbml0IGVhcmx5X3NlcmlhbDgyNTBfd3JpdAogCQlzZXJpYWw4
MjUwX2Vhcmx5X291dChwb3J0LCBVQVJUX0lFUiwgaWVyKTsKIH0KIAorc3RhdGljIGludCBzZXJp
YWw4MjUwX2Vhcmx5Y29uX21hdGNoKHN0cnVjdCBlYXJseWNvbl9kZXZpY2UgKmRldmljZSwKKwkJ
CQkgICAgIHN0cnVjdCB1YXJ0X3BvcnQgKnVwKQoreworCXJldHVybiB1YXJ0X21hdGNoX3BvcnQo
dXAsICZkZXZpY2UtPnBvcnQpOworfQorCiBzdGF0aWMgdW5zaWduZWQgaW50IF9faW5pdCBwcm9i
ZV9iYXVkKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiB7CiAJdW5zaWduZWQgY2hhciBsY3IsIGRs
bCwgZGxtOwpAQCAtMTYxLDYgKzE2Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X3Nlcmlh
bDgyNTBfc2V0dXAKIAl9IGVsc2UKIAkJaW5pdF9wb3J0KGRldmljZSk7CiAKKwlkZXZpY2UtPm1h
dGNoID0gc2VyaWFsODI1MF9lYXJseWNvbl9tYXRjaDsKIAlkZXZpY2UtPmNvbi0+d3JpdGUgPSBl
YXJseV9zZXJpYWw4MjUwX3dyaXRlOwogCXJldHVybiAwOwogfQpJbmRleDogbGludXgtMi42L2Ry
aXZlcnMvdHR5L3NlcmlhbC9lYXJseWNvbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmln
L2RyaXZlcnMvdHR5L3NlcmlhbC9lYXJseWNvbi5jCisrKyBsaW51eC0yLjYvZHJpdmVycy90dHkv
c2VyaWFsL2Vhcmx5Y29uLmMKQEAgLTEyNyw2ICsxMjcsMjEgQEAgc3RhdGljIGludCBfX2luaXQg
cmVnaXN0ZXJfZWFybHljb24oY2hhcgogCXJldHVybiAwOwogfQogCitpbnQgZWFybHljb25fbWF0
Y2goc3RydWN0IHVhcnRfcG9ydCAqdXAsIGNoYXIgKipvcHRpb25zX3ApCit7CisJc3RydWN0IGVh
cmx5Y29uX2RldmljZSAqZGV2aWNlID0gJmVhcmx5X2NvbnNvbGVfZGV2OworCisJaWYgKCFkZXZp
Y2UtPmNvbiB8fCAhKGRldmljZS0+Y29uLT5mbGFncyAmIENPTl9FTkFCTEVEKSkKKwkJcmV0dXJu
IDA7CisKKwlpZiAoZGV2aWNlLT5tYXRjaCAmJiBkZXZpY2UtPm1hdGNoKGRldmljZSwgdXApKSB7
CisJCSpvcHRpb25zX3AgPSBkZXZpY2UtPm9wdGlvbnM7CisJCXJldHVybiAxOworCX0KKworCXJl
dHVybiAwOworfQorCiAvKioKICAqCXNldHVwX2Vhcmx5Y29uIC0gbWF0Y2ggYW5kIHJlZ2lzdGVy
IGVhcmx5Y29uIGNvbnNvbGUKICAqCUBidWY6CWVhcmx5Y29uIHBhcmFtIHN0cmluZwpJbmRleDog
bGludXgtMi42L2luY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaAo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51
eC0yLjYub3JpZy9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgKKysrIGxpbnV4LTIuNi9pbmNs
dWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgKQEAgLTMzNyw2ICszMzcsNyBAQCBzdHJ1Y3QgZWFybHlj
b25fZGV2aWNlIHsKIAlzdHJ1Y3QgdWFydF9wb3J0IHBvcnQ7CiAJY2hhciBvcHRpb25zWzE2XTsJ
CS8qIGUuZy4sIDExNTIwMG44ICovCiAJdW5zaWduZWQgaW50IGJhdWQ7CisJaW50ICgqbWF0Y2gp
KHN0cnVjdCBlYXJseWNvbl9kZXZpY2UgKiwgc3RydWN0IHVhcnRfcG9ydCAqKTsKIH07CiAKIHN0
cnVjdCBlYXJseWNvbl9pZCB7CkBAIC0zNDQsNiArMzQ1LDcgQEAgc3RydWN0IGVhcmx5Y29uX2lk
IHsKIAlpbnQJKCpzZXR1cCkoc3RydWN0IGVhcmx5Y29uX2RldmljZSAqLCBjb25zdCBjaGFyICpv
cHRpb25zKTsKIH07CiAKK2V4dGVybiBpbnQgZWFybHljb25fbWF0Y2goc3RydWN0IHVhcnRfcG9y
dCAqdXAsIGNoYXIgKipvcHRpb25zX3ApOwogZXh0ZXJuIGludCBzZXR1cF9lYXJseWNvbihjaGFy
ICpidWYpOwogZXh0ZXJuIGludCBvZl9zZXR1cF9lYXJseWNvbih1bnNpZ25lZCBsb25nIGFkZHIs
CiAJCQkgICAgIGludCAoKnNldHVwKShzdHJ1Y3QgZWFybHljb25fZGV2aWNlICosIGNvbnN0IGNo
YXIgKikpOwo=
--20cf304275beba9b850512f4dd35--
