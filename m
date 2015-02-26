From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 00/13] Extensible console matching & direct earlycon
Date: Thu, 26 Feb 2015 09:48:44 -0500
Message-ID: <54EF324C.2080205@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com> <CAL_JsqKTtiN-WuQjEQJe22g35BCNaDpXkijNcPyRHojcbbAvhQ@mail.gmail.com> <54ECD6BA.9070009@hurleysoftware.com> <CAL_JsqLTMBJKFcv9cy7UvqOL5=4vDypaP9ZwW5p4rgx74OWxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLTMBJKFcv9cy7UvqOL5=4vDypaP9ZwW5p4rgx74OWxkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On 02/24/2015 03:20 PM, Rob Herring wrote:
> On Tue, Feb 24, 2015 at 1:53 PM, Peter Hurley <peter@hurleysoftware.com> wrote:

[...]

>>>> Direct earlycon
>>>>
>>>> This feature enables arches and proms to start an earlycon directly,
>>>> rather than requiring an "earlycon=" command line parameter.
>>>> Devicetree can already do this via the 'linux,stdout-path' property,
>>>> but arch and prom code requires direct coupling to the serial driver.
>>>>
>>>> This support is implemented by judicious refactoring and the same
>>>> construct that devicetree and early_param use: a link table containing
>>>> the necessary information (name and setup() function) to find and
>>>> bind the appropriate earlycon "driver".
>>>
>>> I've skimmed thru this and it looks like a great improvement.
>>>
>>> One problem we have currently with DT stdout-path and earlycon is a
>>> preferred console does not get registered, so the console will get
>>> switched to tty0 and you lose your console. The problem is DT does not
>>> know the console name to register a preferred console. It looks like
>>> this series may help this problem, but I'm not sure and wanted your
>>> thoughts.
>>
>> I thought that of_alias_scan() + of_console_check() caused DT stdout-path
>> to add_preferred_console() the driver console @ port registration time
>> via uart_add_one_port() -> of_console_check().
>>
>> Is that not how that works?
> 
> Yes, I believe that is how it works with earlycon not enabled. This
> doesn't work when earlycon is enabled with just "earlycon" on the
> command line. The fix I have is here[1], but I don't like putting DT
> specifics into the console code.

After much gnashing of teeth and pulling of hair yesterday, I managed
to mock up the situation you describe, but I need to study it in more
detail. Some things I did learn:

1. The serial console _does_ come back up when using stdout-path but the
   line settings don't match, because the serial core sets them to the
   default of 9600n8 if unspecified.

2. The line settings can now be set with stdout-path like,
     stdout-path = "serial0:115200n8"
   but this breaks DT earlycon (as I wrote in the other email you were
   cc'd on).

3. omap doesn't support ioremap() at early param parsing :(

4. the ARM arch doesn't support fixmap hacking at early param parsing :(

Regards,
Peter Hurley
