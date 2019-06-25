From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
Date: Tue, 25 Jun 2019 17:32:15 -0400
Message-ID: <20190625213215.GB3116@mit.edu>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-5-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625161153.29811-5-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Arseny Maslennikov <ar@cs.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 25, 2019 at 07:11:50PM +0300, Arseny Maslennikov wrote:
> This matches the behaviour of other Unix-like systems that have SIGINFO
> and causes less harm to processes that do not install handlers for this
> signal, making the keyboard status character non-fatal for them.
> 
> This is implemented with the assumption that SIGINFO is defined
> to be equivalent to SIGPWR; still, there is no reason for PWR to
> result in termination of the signal recipient anyway — it does not
> indicate there is a fatal problem with the recipient's execution
> context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> termination requests.

So this is a consequence of trying to overload SIGINFO with SIGPWR.
At least on some legacy Unix systems, the way SIGPWR worked was that
init would broadcast SIGPWR to all userspace process (with system
daemons on an exception list so they could get shutdown last).
Applications which didn't have a SIGPWR handler registered, would just
exit.  Those that did, were expected to clean up in preparation with
the impending shutdown.  After some period of time, then processes
would get hard killed and then system daemons would get shut down and
the system would cleanly shut itself down.

So SIGPWR acted much like SIGHUP, and that's why the default behavior
was "terminate".  Now, as far as I know, we've not actually used in
that way, at least for most common distributions, but there is a sane
reason why things are they way there are, and in there are people who
have been using SIGPWR the way it had originally been intended, there
is risk in overloading SIGINFO with SIGPWR --- in particular, typing
^T might cause some enterprise database to start shutting itself down.  :-)

(In particular it might be worth checking Linux ports of Oracle and
DB2.)

					- Ted
