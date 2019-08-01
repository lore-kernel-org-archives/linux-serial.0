From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Date: Thu, 1 Aug 2019 07:35:33 -0500
Message-ID: <c6750387-8888-0b48-1d82-fd13c4466aa9@landley.net>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru> <20190730161940.GA15798@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730161940.GA15798@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arseny Maslennikov <ar@cs.msu.ru>
Cc: Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Vladimir D. Seleznev" <vseleznv@altlinux.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-serial@vger.kernel.org

On 7/30/19 11:19 AM, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
>> If the three termios local flags isig, icanon, iexten are enabled
>> and the local flag nokerninfo is disabled for a tty governed
>> by the n_tty line discipline, then on receiving the keyboard status
>> character n_tty will generate a status message and write it out to
>> the tty before sending SIGINFO to the tty's foreground process group.
>>
>> This kerninfo line contains information about the current system load
>> as well as some properties of "the most interesting" process in the
>> tty's current foreground process group, namely:
>>  - its PID as seen inside its deepest PID namespace;
>>    * the whole process group ought to be in a single PID namespace,
>>      so this is actually deterministic
>>  - its saved command name truncated to 16 bytes (task_struct::comm);
>>    * at the time of writing TASK_COMM_LEN == 16
>>  - its state and some related bits, procps-style;
>>  - for S and D: its symbolic wait channel, if available; or a short
>>    description for other process states instead;
>>  - its user, system and real rusage time values;
>>  - its resident set size (as well as the high watermark) in kilobytes.
> 
> Why is this really all needed as we have the SysRq handlers that report
> all of this today?

People were lamenting the lack of siginfo in linux back in May, I offered to try
to implement it, several people jumped in to offer suggestions, and it turns out
you can't really do it without kernel support.

https://twitter.com/landley/status/1131764323196522498

 >> The "most interesting" process is chosen as follows:
>>  - runnables over everything
>>  - uninterruptibles over everything else
>>  - among 2 runnables pick the biggest utime + stime
>>  - any unresolved ties are decided in favour of greatest PID.
> 
> This does not feel like something that the tty core code should be doing
> at all.

I couldn't figure out how to do it without kernel support when I tried.

http://lists.landley.net/pipermail/toybox-landley.net/2019-May/010461.html

Rob
