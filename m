From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Date: Thu, 1 Aug 2019 07:44:30 -0500
Message-ID: <f6b331e1-14ff-040b-be2c-8f1a696a721e@landley.net>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru> <20190730161940.GA15798@kroah.com>
 <20190731222359.GA20574@cello> <20190801092020.GB19329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801092020.GB19329@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arseny Maslennikov <ar@cs.msu.ru>
Cc: Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Vladimir D. Seleznev" <vseleznv@altlinux.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-serial@vger.kernel.org

On 8/1/19 4:20 AM, Greg Kroah-Hartman wrote:
>> SysRq is system-wide, whereas this is per-terminal and only cares about
>> one tty which the status char is pressed at and its foreground pgrp
>> (most likely it's the foreground shell job).
>>
>> I hope this is clear enough.
> 
> It is, yes.  My big objection is the crazy code I point out above, as
> well as the "create a totally new interface when we might be able to use
> an existing one" that you need to convince me is really required :)

It's not a new interface, it's a multiple decades old BSD interface our
tcgetattr man page already mentions, which seems to be one of the big things BSD
people miss when using Linux, and which I tried and failed to implement without
kernel support months ago.

I wasn't involved in this kernel patch effort, I got pointed at news coverage
about it by the Android Bionic maintainer:

  http://lists.landley.net/pipermail/toybox-landley.net/2019-June/010536.html

Which is how I wound up cc'd on this thread.

I don't think Android specifically cares about SIGINFO, but they're trying to
support building Android on MacOSX, which means trying to support building it on
FreeBSD, which involves outreach to the BSD community, and they brought up the
lack of ctrl-T and siginfo as a thing they really missed when having to deal
with the Linux command line.

(The fact there _was_ news coverage of the patch for somebody to point me at may
also be an indication of interest floating around out there...)

Rob
