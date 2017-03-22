From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH] [v2][for 4.11]tty: acpi/spcr: QDF2400 E44 checks for
 wrong OEM revision
Date: Wed, 22 Mar 2017 16:45:26 +0100
Message-ID: <20170322154526.GA17123@kroah.com>
References: <1488313833-12430-1-git-send-email-timur@codeaurora.org>
 <CAOZdJXUVz8w2tQdgQ1CyQC9XZL=Gig5kaSEb3b+3Yjap0ExfGg@mail.gmail.com>
 <CAOZdJXW6k=fwaD96dPSikK6kntbKFuhypALG8YGbcWcBcRcLiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXW6k=fwaD96dPSikK6kntbKFuhypALG8YGbcWcBcRcLiw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Dann Frazier <dann.frazier@canonical.com>, Manoj Iyer <manoj.iyer@canonical.com>, linux-serial@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christopher Covington <cov@mykolab.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 22, 2017 at 10:13:00AM -0500, Timur Tabi wrote:
> On Sun, Mar 12, 2017 at 11:19 PM, Timur Tabi <timur@codeaurora.org> wrote:
> > On Tue, Feb 28, 2017 at 2:30 PM, Timur Tabi <timur@codeaurora.org> wrote:
> >> For Qualcomm Technologies QDF2400 SOCs that are affected by erratum E44,
> >> the ACPI oem_revision field is actually set to 1, not 0.
> >>
> >> Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")
> >>
> >> Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
> >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> >
> > Greg, this is a critical fix for our platform.  Can you please pick it
> > up for 4.11-rc3?  Thank you.
> 
> Ok, how about 4.11-rc4?

It's in the queue in tty-linus, right?  If so, that should make it into
4.11-final.

thanks,

greg k-h
