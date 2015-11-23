From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-meson] AMLogic Meson serial driver fixes
Date: Mon, 23 Nov 2015 12:52:18 +0100
Message-ID: <CAOQ7t2aHgsOHsgXCPMGXgwn4HJS+VFgqQp=n3jsPREurVpPp7Q@mail.gmail.com>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-meson@googlegroups.com, linux-kernel@codethink.co.uk, Edward Cragg <edward.cragg@codethink.co.uk>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 18, 2015 at 3:41 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Whilst testing the 4.3 kernel on an AMlogic AM805 (Odroid-C1) with
> a systemd based system, the console has issues with missing parts
> of the output.
>
> This is a set of fixes, and a few cleanups which makes the output
> when the console is set to ttyAML0 usable.
>

nit: next time use '--cover-letter' to generate the cover.

For whole patchset:

Tested-by: Carlo Caione <carlo@endlessm.com>

Thanks!

-- 
Carlo Caione
