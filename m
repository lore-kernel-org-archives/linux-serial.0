From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [PATCH v2 0/7] TTY Keyboard Status Request
Date: Mon, 29 Jul 2019 13:56:12 +0300
Message-ID: <20190729105612.GB25742@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-serial@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 07:11:46PM +0300, Arseny Maslennikov wrote:
> This patch series introduces TTY keyboard status request, a feature of
> the n_tty line discipline that reserves a character in struct termios
> (^T by default) and reacts to it by printing a short informational line
> to the terminal and sending a Unix signal to the tty's foreground
> process group. The processes may, in response to the signal, output a
> textual description of what they're doing.
>=20
> The feature has been present in a similar form at least in
> Free/Open/NetBSD; it would be nice to have something like this in Linux
> as well. There is an LKML thread[1] where users have previously
> expressed the rationale for this.
>=20
> The current implementation does not break existing kernel API in any
> way, since, fortunately, all the architectures supported by the kernel
> happen to have at least 1 free byte in the termios control character
> array.
>=20
> The series should cleanly apply to tty-next.
>=20
> To thoroughly test these, one might need at least a patched stty among
> other tools, so I've brought up a simple initrd generator[2] which can
> be used to create a lightweight environment to boot up in a VM and to
> fiddle with.
>=20
> [1] https://lore.kernel.org/lkml/1415200663.3247743.187387481.75CE9317@we=
bmail.messagingengine.com/
> [2] https://github.com/porrided/tty-kb-status-userspace
>=20
> v2 <- v1: removed useless debugging bits.
>=20
> Discussion of v1:
> https://lore.kernel.org/lkml/20190605081906.28938-1-ar@cs.msu.ru/
>=20
> Arseny Maslennikov (7):
>   signal.h: Define SIGINFO on all architectures
>   tty: termios: Reserve space for VSTATUS in .c_cc
>   n_tty: Send SIGINFO to fg pgrp on status request character
>   linux/signal.h: Ignore SIGINFO by default in new tasks
>   tty: Add NOKERNINFO lflag to termios
>   n_tty: ->ops->write: Cut core logic out to a separate function
>   n_tty: Provide an informational line on VSTATUS receipt
>=20
>  arch/alpha/include/asm/termios.h         |   4 +-
>  arch/alpha/include/uapi/asm/termbits.h   |   2 +
>  arch/arm/include/uapi/asm/signal.h       |   1 +
>  arch/h8300/include/uapi/asm/signal.h     |   1 +
>  arch/ia64/include/asm/termios.h          |   4 +-
>  arch/ia64/include/uapi/asm/signal.h      |   1 +
>  arch/ia64/include/uapi/asm/termbits.h    |   2 +
>  arch/m68k/include/uapi/asm/signal.h      |   1 +
>  arch/mips/include/asm/termios.h          |   4 +-
>  arch/mips/include/uapi/asm/signal.h      |   1 +
>  arch/mips/include/uapi/asm/termbits.h    |   2 +
>  arch/parisc/include/asm/termios.h        |   4 +-
>  arch/parisc/include/uapi/asm/signal.h    |   1 +
>  arch/parisc/include/uapi/asm/termbits.h  |   2 +
>  arch/powerpc/include/asm/termios.h       |   4 +-
>  arch/powerpc/include/uapi/asm/signal.h   |   1 +
>  arch/powerpc/include/uapi/asm/termbits.h |   2 +
>  arch/s390/include/asm/termios.h          |   4 +-
>  arch/s390/include/uapi/asm/signal.h      |   1 +
>  arch/sparc/include/asm/termios.h         |   4 +-
>  arch/sparc/include/uapi/asm/signal.h     |   2 +
>  arch/sparc/include/uapi/asm/termbits.h   |   2 +
>  arch/x86/include/uapi/asm/signal.h       |   1 +
>  arch/xtensa/include/uapi/asm/signal.h    |   1 +
>  arch/xtensa/include/uapi/asm/termbits.h  |   2 +
>  drivers/tty/Makefile                     |   3 +-
>  drivers/tty/n_tty.c                      |  70 ++++-
>  drivers/tty/n_tty_status.c               | 337 +++++++++++++++++++++++
>  include/asm-generic/termios.h            |   4 +-
>  include/linux/sched.h                    |   7 +
>  include/linux/signal.h                   |   5 +-
>  include/linux/tty.h                      |   7 +-
>  include/uapi/asm-generic/signal.h        |   1 +
>  include/uapi/asm-generic/termbits.h      |   2 +
>  34 files changed, 457 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/tty/n_tty_status.c
>=20

> Date: Tue, 25 Jun 2019 19:11:46 +0300
Ping.

The series should cleanly apply to 5.3-rc2 and to tty-next as of writing
this email.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl0+0MwACgkQ9dQjyAYL
01CceRAAxHmrLCcZw6xWtjgyTLTvK2ktb1A5NKNpAErfPmBihjA7Vn5k9QBBegyL
uRv95D/Hoz1LSXP7rwaQvKdH00S/ZlkHFHdw6hH7Q4gE6lN9L3jJoFY+lX9/9Oqw
BCa94zOedislJIgRqPfs/OicYaSpHndNStfej9tFvhk43q0eULS+f9jxDsrO85BY
nFbV2ECs3rd6ujT7tZj1Wc/NhViz0BsPDpfwassNov8Ik/L1UA5KPh2N8ezapGr4
uP0K6YbDXfxQI2ivI2wB4d9BwNlAunDw0reVK2ENKw8vhWrsMbj9mLUexcaEJBbs
nXxh4x7QdviSFmlgV0Jl/8Jwih4tijDuCcakV5IG2WPDSy04rKGJZeNvKDrVn2By
GhHIqy7YTo7WLkRRM/Q24pG9wM5XX3TKemN4wIfkBsB+ZalxWtkWqsuOo1ftMBxk
OUPl7PR25wUpKXGXVVzNB1rSvUHNaZNEe5tUSeOpMuhSNrI31EylxJOBNtm0yNsc
lEpNNERaEo3hBWt4PCbXZk7J1xSAPMUsTnzz3ClwBGcLsd8DovajnRLNeN56ar00
uS/iSwCug8f45CQy99KsCbQfw0vpO1IPAIkmse7uYrERxSMmRCqkksBAcOmgJzoV
i67Klay9PfUBNJyX3OLEAuOadYXdi7a4b0G7/BNMo7VH7IM4yq8=
=hAzz
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
