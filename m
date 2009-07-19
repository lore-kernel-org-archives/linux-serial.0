From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [RFC] tty (or char) bus?
Date: Sun, 19 Jul 2009 15:34:48 +0200
Message-ID: <20090719133448.GA5328@const.famille.thibault.fr>
References: <4A5CA4CB.8070500@tis.icnet.pl> <20090717175428.GB4852@const.linuxsymposium.org> <4A631D5A.3030105@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754295AbZGSNew@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A631D5A.3030105@imap.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-serial@vger.kernel.org

Tilman Schmidt, le Sun 19 Jul 2009 15:19:22 +0200, a =E9crit :
> The only inconvenience is how LDs are loaded and attached to a serial
> interface, via the TIOCSETD ioctl, because you need a userspace daemo=
n
> which keeps the tty device open so that the LD stays attached to it.

Yes, that's a burden for me also, while I could just tell my module to
use ttyS0 through parameters for instance.

Samuel
