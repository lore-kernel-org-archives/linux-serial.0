From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/4] tty: Abstract and encapsulate tty->closing behavior
Date: Mon, 9 Nov 2015 06:58:42 -0500
Message-ID: <56408A72.4050301@hurleysoftware.com>
References: <1447020173-32207-1-git-send-email-peter@hurleysoftware.com>
 <1447020173-32207-4-git-send-email-peter@hurleysoftware.com>
 <20151109091214.GD16715@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20151109091214.GD16715@sig21.net>
Sender: netdev-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, Karsten Keil <isdn@linux-pingi.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>, Mark Hounschell <markh@compro.net>
List-Id: linux-serial@vger.kernel.org

On 11/09/2015 04:12 AM, Johannes Stezenbach wrote:
> On Sun, Nov 08, 2015 at 05:02:52PM -0500, Peter Hurley wrote:
>> +void tty_ldisc_closing(struct tty_struct *tty)
>> +{
>> +	struct tty_ldisc *ld = tty_ldisc_ref(tty);
>> +
>> +	if (ld->ops->closing)
>> +		ld->ops->closing(tty);
>> +	if (ld)
>> +		tty_ldisc_deref(ld);
>> +}
> 
> That looks strange.  Do you need to check ld _before_ dereferencing?

Yes. Thanks for noticing.

Regards,
Peter Hurley
