From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 01/68] USB: cdc-acm, use tty_standard_install
Date: Mon, 5 Mar 2012 15:14:19 +0100
Message-ID: <201203051514.19274.oneukum@suse.de>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz> <1330955575-26641-2-git-send-email-jslaby@suse.cz> <4F54C7BD.1020105@suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F54C7BD.1020105@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.name>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Am Montag, 5. M=E4rz 2012, 15:03:41 schrieb Jiri Slaby:
> Forgot to CC maintainers. Done now.
>=20
> On 03/05/2012 02:51 PM, Jiri Slaby wrote:
> > This is a piece I missed the last time.
> >=20
> > Do not copy the functionality all over the tree. Instead, use the
> > helper the tty layer provides us with.
> >=20
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Oliver Neukum <oneukum@suse.de>
