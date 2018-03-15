From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/3] serial: core: Allow skipping old serial port initialization
Date: Wed, 14 Mar 2018 17:55:19 -0700
Message-ID: <CAGXu5j+cOZXCTx3SZT2u5rVv4zDpEhX6hjdp+4DUtN=kE+Q-PQ@mail.gmail.com>
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-4-djkurtz@chromium.org>
 <CAGXu5jK4QdG83FGAx94GAmU=tpuhN1dypTh5n_Pes8n7shEZuw@mail.gmail.com>
 <CAGXu5jJXNK3h5P-YzRJ3hxBer305ik4FHuhcixzprnRnefU7Qw@mail.gmail.com> <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Durbin <adurbin@chromium.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, David Howells <dhowells@redhat.com>, Vignesh R <vigneshr@ti.com>, Sean Young <sean@mess.org>, Jeffy <jeffy.chen@rock-chips.com>, Doug Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 14, 2018 at 5:23 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Wed, Mar 14, 2018 at 5:00 PM Kees Cook <keescook@chromium.org> wrote:
>
>> On Wed, Mar 14, 2018 at 3:58 PM, Kees Cook <keescook@chromium.org> wrote:
>> > On Wed, Mar 14, 2018 at 2:44 PM, Daniel Kurtz <djkurtz@chromium.org>
> wrote:
>> > Sorry for being dense. What tree is this against? I can't find mention
>> > of amdcz in Linus's tree nor linux-next.
>
>> As I watched this email send, I noticed the "3/3" in the Subject. ;) I
>> see the amdcz support now. :P
>> https://patchwork.kernel.org/project/LKML/list/?submitter=18441
>
>> >> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> >> index a27ef5f56431..02570edaddd8 100644
>> >> --- a/include/linux/serial_8250.h
>> >> +++ b/include/linux/serial_8250.h
>> >> @@ -136,6 +136,12 @@ struct uart_8250_port {
>> >>         struct uart_8250_em485 *em485;
>> >>  };
>> >>
>> >> +#ifdef CONFIG_SERIAL_8250
>> >> +extern bool serial8250_skip_old_ports;
>> >> +#else
>> >> +static const bool serial8250_skip_old_ports;
>> >> +#endif
>> >
>> > Where does serial8250_skip_old_ports get used where CONFIG_SERIAL_8250
>> > isn't defined? (i.e. why is the #ifdef needed here?)
>
>> This question still stands, though.
>
>  From the same patch: https://patchwork.kernel.org/patch/10283641/
>
> if (CONFIG_ACPI_SPCR_TABLE && !CONFIG_SERIAL_8250)
>
> in other words, if serial ports are disabled, but we still want to parse
> the APCI_SPCR_TABLE, which "defaults y if X86".
> Perhaps that logic should be changed (no need to parse ACPI SPCR table if
> we are going to disable serial anyway)?

But won't this break? "static const bool ..." but the code tries to
set a value but I'd expect the compiler to still yet about it?

I think you could drop the .h #ifdef and use:

if (IS_ENABLED(CONFIG_SERIAL_825) && amdcz_present(...)) {

-Kees

-- 
Kees Cook
Pixel Security
