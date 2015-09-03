From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v5 05/11] drivers: PL011: refactor pl011_probe()
Date: Thu, 03 Sep 2015 13:09:40 -0500
Message-ID: <55E88CE4.7080401@tabi.org>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
 <CAOZdJXVgRQZhEfYY9YdpiQ=n1D56yYL84s42V4hd2=YX2k48ZA@mail.gmail.com>
 <55E87B3E.8070106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55E87B3E.8070106@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <moorray3@wp.pl>, GregKH <gregkh@linuxfoundation.org>, "nareshgbhat@gmail.com" <nareshgbhat@gmail.com>, "mlangsdo@redhat.com" <mlangsdo@redhat.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 09/03/2015 11:54 AM, Andre Przywara wrote:

> I don't get where pl011_early_write() would need any kind of PL011 struct.
> It only references structures defined in the serial core, so it's
> completely dumb MMIO writes and reads, using only the base address
> provided on the command line.
> Are you by any chance mixing up early console and the normal console? To
> me it looks like early console just uses the three tiny functions
> defined just before the declaration and it does not touch vendor at all,
> isn't it?
>
> As for the broken part, any chance you were testing -next, which has
> some patches that broke early console, as we learned today?[1]

I have to apologize -- I forgot that I applied an internal patch that 
modified this code, and the bug is in that patch, not yours.  Your code 
is fine as is.
