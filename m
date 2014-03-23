From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] Generic serial earlycon
Date: Sun, 23 Mar 2014 20:49:41 +0100
Message-ID: <201403232049.41866.arnd@arndb.de>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <201403222301.30222.arnd@arndb.de>
 <CAL_Jsq+j4ixVbfue62q_tOHb-HPA2jAxwZtTjtLy6jE9crGvsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+j4ixVbfue62q_tOHb-HPA2jAxwZtTjtLy6jE9crGvsg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sunday 23 March 2014, Rob Herring wrote:
> IIRC, the unflattening cannot be done before memblock is up which is
> in arm_memblock_init. I believe that will get done earlier similar to
> PPC with Laura's meminfo removal series. However, in interest of
> getting output enabled as early as possible, the earliest point is
> always going to be with a flat tree. So I think we do want to be able
> to parse the flat tree for this. There's code in u-boot to do the
> address translation on FDT we can steal. Really, i'd like to put that
> code in libfdt, but there's a licensing problem with the u-boot code
> being GPL and libfdt being BSD.

I suppose it depends on what the goal is. If you are trying to get as
close as possible to the debug_ll functionality without losing the
ability to turn it on unconditionally, I agree that it needs to be done
on the flat tree.

However, the goal that interests me more at the moment is to have
reliable debug output done in a simple way earlier than what we have
today with the normal console support. For this, it seems a better
tradeoff to initialize the early console slightly later. This
can actually be done independent of the the command line option,
I don't see any downsides from having a compile-time option that
would initialize the early console from setup_arch (after
unflatten_device_tree) whenever there is a linux,stdout-path
property that points to a usable device.

	Arnd
