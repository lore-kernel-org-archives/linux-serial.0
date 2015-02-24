From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 00/13] Extensible console matching & direct earlycon
Date: Tue, 24 Feb 2015 14:53:30 -0500
Message-ID: <54ECD6BA.9070009@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com> <CAL_JsqKTtiN-WuQjEQJe22g35BCNaDpXkijNcPyRHojcbbAvhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKTtiN-WuQjEQJe22g35BCNaDpXkijNcPyRHojcbbAvhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On 02/24/2015 02:27 PM, Rob Herring wrote:
> On Tue, Feb 24, 2015 at 10:36 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> Hi Greg & Andrew,
>>
>> This patch series implements:
>>   1. console-definable (aka extensible) matching
>>   2. generic earlycon-to-console handoff via extensible matching
>>   3. arch/prom support for direct earlycon
>>
>>
>> Extensible console matching
>>
>> Extensible console matching enables the console itself to define the
>> conditions for a "command line" match. This mimics the design of
>> device matching in the driver model. Two important use-cases which this
>> feature enables are generic earlycon-to-console handoff and support
>> for driver migration.
>>
>> Earlycon-to-console handoff was implemented in 2007. Console command
>> lines of the form:
>>    console=uart,io,0x3f8,115200n8
>> start an earlycon and later allow the 8250 driver console to takeover.
>> Unfortunately this implementation requires direct coupling between
>> the earlycon and the console and is facilitated by ugly hacks like
>> editing the console command line in-place.
>>
>> Extensible console matching allows the 8250 driver to directly match
>> that console command line instead, and enables other serial drivers
>> to trivially support console handoff themselves.
>>
>> In addition, extensible console matching allows a new driver to
>> provide support for a different driver's console. This requirement
>> stems from needing to minimize breakage when migrating serial drivers.
>> Since many devices are based on the original 8250/16550 designs
>> but sometimes have features incompatible with the existing 8250 driver
>> support, the initial driver is often standalone. When/if the standalone
>> driver is migrated to the 8250 driver, the problem of console names in
>> the command line remains. Extensible console matching enables a simple
>> migration path.
>>
>>
>> Direct earlycon
>>
>> This feature enables arches and proms to start an earlycon directly,
>> rather than requiring an "earlycon=" command line parameter.
>> Devicetree can already do this via the 'linux,stdout-path' property,
>> but arch and prom code requires direct coupling to the serial driver.
>>
>> This support is implemented by judicious refactoring and the same
>> construct that devicetree and early_param use: a link table containing
>> the necessary information (name and setup() function) to find and
>> bind the appropriate earlycon "driver".
> 
> I've skimmed thru this and it looks like a great improvement.
> 
> One problem we have currently with DT stdout-path and earlycon is a
> preferred console does not get registered, so the console will get
> switched to tty0 and you lose your console. The problem is DT does not
> know the console name to register a preferred console. It looks like
> this series may help this problem, but I'm not sure and wanted your
> thoughts.

I thought that of_alias_scan() + of_console_check() caused DT stdout-path
to add_preferred_console() the driver console @ port registration time
via uart_add_one_port() -> of_console_check().

Is that not how that works?

Regards,
Peter Hurley
