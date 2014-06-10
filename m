From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
Date: Tue, 10 Jun 2014 17:38:22 -0500
Message-ID: <CAL_JsqLccXqcsQXoc1ZLcuqUAQMNHW_iApdNpd1ptnNS+1ut0A@mail.gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
 <20140503220731.GA10927@kroah.com>
 <20140503221658.GA13403@kroah.com>
 <CA+8MBb+7f1bOnJjJWj1vxa0UNuQwz7OGRDR_QFTxOT=9cynabQ@mail.gmail.com>
 <CA+8MBbKE1E2uq9LefiDAV9hv2Z8OTkjx9mkXjE6_--F_emRC8A@mail.gmail.com>
 <CAL_JsqKvoO9acX==-LdD6boO=B3xr=ijra_G0uqRZGzACZZUJg@mail.gmail.com>
 <CA+8MBbLooWm9xys+gYa5uL1eVTH-qzaR+RaZgsrqV-8XkqGadQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+8MBbLooWm9xys+gYa5uL1eVTH-qzaR+RaZgsrqV-8XkqGadQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 10, 2014 at 3:52 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Mon, Jun 9, 2014 at 4:18 PM, Rob Herring <robherring2@gmail.com> wrote:
>> It should do auto detect of the baud-rate if it is not specified which
>> for 8250 is just reading the baud-rate divider and calculating the
>> baud-rate using the uart clock. It should just reprogram the divider
>> with the same divider value. I don't see anything obvious why this
>> would have broken.
>
> Something very weird is happening.  Output is good so long as I put the
> trailing ",115200" on the command line.
>
> But I made early_serial8250_setup() printk() the return value it got
> from probe_baud() - in case is was somehow getting 115201 or some
> other silly value ... nope. Exactly 115200.
>
> I also can't explain why the "noise" comes and goes a dozen
> times during boot,
>
> Does some other place in the kernel look at the "uart..." command
> line argument?

Would you be using drivers/firmware/pcdp.c as that is ia64 only? That
shouldn't have an impact that I can see.

Can you print the options string in serial8250_console_setup? Maybe it
is getting lost when the real console is setup.

Rob
