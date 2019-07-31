From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Date: Thu, 1 Aug 2019 01:23:59 +0300
Message-ID: <20190731222359.GA20574@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru>
 <20190730161940.GA15798@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730161940.GA15798@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-serial@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 06:19:40PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
> > If the three termios local flags isig, icanon, iexten are enabled
> > and the local flag nokerninfo is disabled for a tty governed
> > by the n_tty line discipline, then on receiving the keyboard status
> > character n_tty will generate a status message and write it out to
> > the tty before sending SIGINFO to the tty's foreground process group.
> >=20
> > This kerninfo line contains information about the current system load
> > as well as some properties of "the most interesting" process in the
> > tty's current foreground process group, namely:
> >  - its PID as seen inside its deepest PID namespace;
> >    * the whole process group ought to be in a single PID namespace,
> >      so this is actually deterministic
> >  - its saved command name truncated to 16 bytes (task_struct::comm);
> >    * at the time of writing TASK_COMM_LEN =3D=3D 16
> >  - its state and some related bits, procps-style;
> >  - for S and D: its symbolic wait channel, if available; or a short
> >    description for other process states instead;
> >  - its user, system and real rusage time values;
> >  - its resident set size (as well as the high watermark) in kilobytes.
>=20
> Why is this really all needed as we have the SysRq handlers that report
> all of this today?

Different use-cases have different needs; SysRq is targeted at a different
audience; see below.

> > The "most interesting" process is chosen as follows:
> >  - runnables over everything
> >  - uninterruptibles over everything else
> >  - among 2 runnables pick the biggest utime + stime
> >  - any unresolved ties are decided in favour of greatest PID.
>=20
> This does not feel like something that the tty core code should be doing
> at all.

Yes, this selection part is quite clumsy. In defense of it, one could
argue that we already have the whole n_tty implemented in kernel-space.

One way we could get rid of this is to display a summarized statistic
for the whole pgrp: pgid, oldest real time, cumulative utime and stime,
cumulative memory usage. Would this be more acceptable? Are there any
other ideas?

> > While the kerninfo line is not very useful for debugging the kernel
> > itself, since we have much more powerful debugging tools, it still gives
> > the user behind the terminal some meaningful feedback to a VSTATUS that
> > works even if no processes respond.
>=20
> That's what SysRq is for.  If there's a specific set of values that we
> don't currently report in that facility, why not just add the
> information there?  It's much simpler and "safer" that way.

SysRq is intended for the person either administrating the system to be use=
d in
emergency (e.g. f for the oom kill, the famous s-u-b combo also comes to
mind) or debugging the kernel, and it indeed does a much better job for
those purposes.  In both use-cases mentioned the person has access to
the system console, where the sysrq button handlers produce all their
output, if any, and to either a physical keyboard / serial console or to
/proc/sysrq-trigger, whose mode is 0200 (writable by uid 0 only).

The use-case for this is different: the ^T-line as proposed by this
patch is for the user that interacts with a system through a terminal, who
wants to be informed not about the whole system (sort of what SysRq-t
tells you), but about what they run on that particular tty.
This is much less about "why does my system/kernel seem to hang?" or
exposing low-level internals (registers, hrtimers, locks, ...), and more
about "is my SSH terminal session unresponsive?" and "I ran a command,
it doesn't finish, how's it doing?".
e.g. A user might want to know if their SSH connection is alive without
interrupting anything, while having no access both to SysRq and console,
and no one in fg pgrp actually handles SIGINFO.

SysRq is system-wide, whereas this is per-terminal and only cares about
one tty which the status char is pressed at and its foreground pgrp
(most likely it's the foreground shell job).

I hope this is clear enough.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl1CFPcACgkQ9dQjyAYL
01AcOA/9HXsK7LNkhYfAWqTgVMkfOaFgAp9Y1KYIpmWJ58Nuy/FM5ukUWkM+JL75
ro8cVOmRYv3+foTkJ0perwlswgivYV8dEq3KtGi8lu/OOmwZzip4TTaxC4Imc+Yz
RTjCZTtzR1RvFJyV1im5yuBdKaa4iO6nEYl7uQFnLnhI4xP0qShHTusHihA2vrxI
2uP9+6RNcS7fcNcfYHFyPVLHwf0iARgeQtsrlGSdakjURCqfBvuw37q/K2nHXXDs
SqfJNVnFABcd3h2RbfTKsnHSxcURHbtE+dRyFOTuFumQcKGznOO46goqPEkVp1ly
0TuJOasObAOk0PQr1bfebKkqmtakLfl6vySFSJjuDbp+waui1PwxOy3VUXp+tqu/
qBgJo4JArdmFTR9jRPe5Q7rhtR6GStJBFPTmoXsoJ3TZGBp4oCptfRN4V78rHY8u
Ii+Y35SkbFHAtEtUKG4lpskS7iGsDXL7DTsjFrduMh3ZvSU9hyoiLQ2g2HzikJ3D
+hujuMpTrDM7FoGviSWO6wbtxlnXmvcZYasKvuT13GMYJvnXb1EM81laTpePIMzj
Q7MhqZTx9B88AeqmkM5kFZEBh+hYXCpcJ1AIMjkTDDjmbbpfc4wYp2hkSmeV9iHU
kZWOlWODSzTh+BCFjPSHERpLI+FDp05xgY4RHAjT8N/9NeUqIiU=
=h84y
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
