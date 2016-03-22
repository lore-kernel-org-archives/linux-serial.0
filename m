From: Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on
 ath79
Date: Tue, 22 Mar 2016 08:40:46 +0300
Message-ID: <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>
References: <56F07DA1.8080404@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Mamonov <pmamonov@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 22 Mar 2016 00:02:57 +0100
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/co=
nsole
> handover on some ath79 systems on OpenWrt. I've seen this issue mysel=
f on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to oth=
er
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs l=
ike
> QCA953x likewise.
>=20
> See the log below for the exact place it hangs; the log was taken in =
during
> a good boot; a bad boot will just hang forever at the marked location=
=2E The
> issue is extremely hard to debug, as changing the timing in any way (=
like
> adding additional printk) will usually make it work without problems.=
 (Even
> recompiling the kernel with the same config, but different uname time=
stamp
> will make the occurence more or less likely)
>=20
> My theory is the following:
>=20
> As soon as ttyS0 is detected and installed as the console, there are =
two
> console drivers active on the serial port at the same time: early0 an=
d
> ttyS0. I suspect that the hang occurs when the primitive early0
> implementation prom_putchar_ar71xx waits indefinitely on THRE,

Can you use EJTAG to prove your theory?

--=A0
Best regards,
=A0 Antony Pavlov
