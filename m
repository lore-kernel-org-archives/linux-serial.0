From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] TTY: serial, fix build of some drivers
Date: Wed, 31 Aug 2011 22:28:50 +0100
Message-ID: <20110831222850.494bf19d@lxorguk.ukuu.org.uk>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
	<1314818699-10873-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314818699-10873-3-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 31 Aug 2011 21:24:58 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> I'm getting build errors such as:
> .../tty/serial/max3107.c: In function =E2=80=98put_data_to_circ_buf=E2=
=80=99:
> .../tty/serial/max3107.c:149:2: error: implicit declaration of functi=
on =E2=80=98tty_insert_flip_string=E2=80=99
>=20
> Those drivers need to include linux/tty_flip.h. The question is
> whether we want to fix them at all. As they are broken for some time
> already and nobody noticed...

Config options randomly including it ?
