From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [Cocci] [RFC] firmware: annotate thou shalt not request fw on
 init or probe
Date: Thu, 3 Sep 2015 13:45:50 +0200
Message-ID: <55E832EE.7050801@users.sourceforge.net>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Alessandro Rubini <rubini@gnudd.com>, Alexander Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jie Yang <yang.jie@intel.com>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kay Sievers <kay@vrfy.org>, Kevin Cernekee <cernekee@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Ming Lei <ming.lei@canonical.com>, Takashi Iwai <tiwai@suse.de>, Tom Gundersen <teg@jklm.no>, Yalin Wang <yalin.wang2010@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> +@ calls_fw_on_init depends on defines_module_init @
> +identifier defines_module_init.init;
> +position p1;
> +@@
> +
> +init(void)
> +{
> + ...

Would it make sense to use the specification "when any"
for such a SmPL ellipsis?
http://coccinelle.lip6.fr/docs/main_grammar004.html


> +(
> +request_firmware@p1(...)
> +|
> +request_firmware_nowait@p1(...)
> +|
> +request_firmware_direct@p1(...)
> +)
> +...
> +}


Are there any more source code variants to check today?

Regards,
Markus
