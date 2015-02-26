From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH -next 00/13] Extensible console matching & direct earlycon
Date: Thu, 26 Feb 2015 10:09:43 -0600
Message-ID: <CAL_JsqKEWKuz+qUDkEyWzAa0rV6Ttz8RnfySw3eEZdffr5xZ6w@mail.gmail.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
 <CAL_JsqKTtiN-WuQjEQJe22g35BCNaDpXkijNcPyRHojcbbAvhQ@mail.gmail.com>
 <54ECD6BA.9070009@hurleysoftware.com> <CAL_JsqLTMBJKFcv9cy7UvqOL5=4vDypaP9ZwW5p4rgx74OWxkg@mail.gmail.com>
 <54EF324C.2080205@hurleysoftware.com> <CAL_JsqLcTHNpsXmG1TSPAvvEpdVYahnFm-LRLUUWJd3eotMAEQ@mail.gmail.com>
 <54EF41BC.2030900@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EF41BC.2030900@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 26, 2015 at 9:54 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 02/26/2015 09:58 AM, Rob Herring wrote:
>> On Thu, Feb 26, 2015 at 8:48 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> Hi Rob,
>>>
>>> On 02/24/2015 03:20 PM, Rob Herring wrote:
>>>> On Tue, Feb 24, 2015 at 1:53 PM, Peter Hurley <peter@hurleysoftware.com> wrote:

[...]

>>> 3. omap doesn't support ioremap() at early param parsing :(
>>
>> ARM in general does not.
>
> I was looking at mach-bcm to see how it was that the iotable_init() didn't
> blow up, but maybe it does?

iotable_init is basically just a list of page table entries to create
and uses the early page table setup code.

Rob
