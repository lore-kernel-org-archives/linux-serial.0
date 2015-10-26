From: Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size
 in pl011_fifo_to_tty()"
Date: Mon, 26 Oct 2015 13:47:01 +0800
Message-ID: <20151026054700.GC7305@arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151023103056.GI4801@e103592.cambridge.arm.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: gregkh@linuxfoundation.org, timur@codeaurora.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The 10/23/2015 11:31, Dave Martin wrote:
> On Fri, Oct 23, 2015 at 06:00:00PM +0800, Huang Shijie wrote:
> > The commit 71a5cd8a4 makes the console hang for some times.
> > This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.
>
> What hangs?  Input?  Output?  Both?
>
> Is CREAD set on the terminal?  If only input hangs, it's possible CREAD
> is not set and we were previously getting away with it, though I can't
> easily see why it should be unset...
I think the hang is not caused by this patch: 71a5cd8a4a2602a6e9.

I tried to bisect the linux-next today, but i still cannot find the root cause,
the following is the log from bisect:

 =============================================
git bisect start
# bad: [6dcf94ff0c9e28e5790799e53641dd256745f425] Add linux-next specific files for 20151022
git bisect bad 6dcf94ff0c9e28e5790799e53641dd256745f425
# good: [7379047d5585187d1288486d4627873170d0005a] Linux 4.3-rc6
git bisect good 7379047d5585187d1288486d4627873170d0005a
# good: [c3d1cd2b1e542e5ba6a844fd40fa5e62a896cfc2] Merge remote-tracking branch 'block/for-next'
git bisect good c3d1cd2b1e542e5ba6a844fd40fa5e62a896cfc2
# good: [c3af8a28f43315fc46753465a4e77e5619dd9f30] staging: IB/hfi1: use TASK_COMM_LEN in hfi1_ctxtdata
git bisect good c3af8a28f43315fc46753465a4e77e5619dd9f30
# good: [41783383487fc80d2acdd78fb9133d441371510b] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect good 41783383487fc80d2acdd78fb9133d441371510b
# good: [1709035022efcdcf316010592537de2033335e4e] Merge remote-tracking branch 'target-merge/for-next-merge'
git bisect good 1709035022efcdcf316010592537de2033335e4e
# good: [641e7642617127da14e683da8ec690d8404ea83f] rbtree-clarify-documentation-of-rbtree_postorder_for_each_entry_safe-fix
git bisect good 641e7642617127da14e683da8ec690d8404ea83f
# bad: [a1a15239a59287d6d56cf43e84d3cc878bca828f] Merge remote-tracking branch 'clk/clk-next'
git bisect bad a1a15239a59287d6d56cf43e84d3cc878bca828f
# bad: [87fd47bb754496a1ba005fca022eee1b30b3cee9] Merge remote-tracking branch 'pwm/for-next'
git bisect bad 87fd47bb754496a1ba005fca022eee1b30b3cee9
# good: [ec879f1272283c040bc70e1a1fff5edbb547be59] pinctrl: baytrail: Fix compilation warnings when !CONFIG_PM
git bisect good ec879f1272283c040bc70e1a1fff5edbb547be59
# good: [f32517bf1ae0a2de72b3f27200233bd3ad65bfeb] gpio: pca953x: support ACPI devices found on Galileo Gen2
git bisect good f32517bf1ae0a2de72b3f27200233bd3ad65bfeb
# good: [677b2ff4afd9996eabefc9472c701211b4b49e87] gpio: add a real time compliance checklist
git bisect good 677b2ff4afd9996eabefc9472c701211b4b49e87
# good: [2b8b0ef354cc055f855d8cb86aeae9089517fba7] pwm: atmel-hlcdc: add sama5d2 SoC support.
git bisect good 2b8b0ef354cc055f855d8cb86aeae9089517fba7
# bad: [8706693e4ee14eb6051be8caa9850312d843b88f] Merge remote-tracking branch 'gpio/for-next'
git bisect bad 8706693e4ee14eb6051be8caa9850312d843b88f
# good: [d629f2b585cb766ed9732008976d029cb5d5e584] virtio: introduce avail cache
git bisect good d629f2b585cb766ed9732008976d029cb5d5e584
# bad: [fb4e51e2df938f7f7e3ec3c198beb2d449e2f548] Merge remote-tracking branch 'vhost/linux-next'
git bisect bad fb4e51e2df938f7f7e3ec3c198beb2d449e2f548
# good: [cd5c6b35041cc595ff722226fb80450b9368dbbc] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good cd5c6b35041cc595ff722226fb80450b9368dbbc
# first bad commit: [fb4e51e2df938f7f7e3ec3c198beb2d449e2f548] Merge remote-tracking branch 'vhost/linux-next'

 =============================================
 thanks
 Huang Shijie



________________________________

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
