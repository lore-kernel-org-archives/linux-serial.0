From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] serial: sirf: Simplify a test
Date: Thu, 10 Nov 2016 22:18:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611102217040.1970@hadrien>
References: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr> <2916662.De1FDumaQl@wuerfel> <39a1050e-fb64-a6e5-8939-4e01631e59ea@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-672903137-1478812712=:1970"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39a1050e-fb64-a6e5-8939-4e01631e59ea@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, baohua@kernel.org, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-672903137-1478812712=:1970
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT



On Tue, 8 Nov 2016, Christophe JAILLET wrote:

> Le 07/11/2016 à 14:50, Arnd Bergmann a écrit :
> > On Tuesday, November 1, 2016 8:03:33 AM CET Christophe JAILLET wrote:
> > > 'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the
> > > test
> > > can be simplified to be more consistent.
> > >
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > The change looks correct in principle. It would be good to automate looking
> > for other instances of this bug. How did you find it? Do you have e.g. a
> > coccinelle script or did you just stumble over the issue by accident?
> Hi,
>
> You can have an idea of the strategy used in this post:
>    https://lkml.org/lkml/2016/11/1/388
>
> Julia is currently working on a more complete strategy in order to find such
> issues.

I have a set of reports in the files listed below.  If anyone wants to
take a look at them, I would be happy to send them along.  It is
definitely possible that the list contains false positives.

julia

arch/arm64/kernel/ptrace.c
arch/arm/mach-davinci/usb-da8xx.c
arch/arm/mach-omap2/pm.c
arch/mips/ath79/clock.c
arch/mips/ath79/pci.c
arch/sh/boards/mach-sdk7786/setup.c
arch/sh/kernel/cpu/clock.c
arch/sh/kernel/cpu/sh2a/clock-sh7264.c
arch/sh/kernel/cpu/sh2a/clock-sh7269.c
arch/sh/kernel/cpu/sh4a/clock-sh7343.c
arch/sh/kernel/cpu/sh4a/clock-sh7366.c
arch/sh/kernel/cpu/sh4a/clock-sh7722.c
arch/sh/kernel/cpu/sh4a/clock-sh7723.c
arch/sh/kernel/cpu/sh4a/clock-sh7724.c
arch/sh/kernel/cpu/sh4a/clock-sh7734.c
arch/sh/kernel/cpu/sh4a/clock-sh7757.c
arch/sh/kernel/cpu/sh4a/clock-sh7785.c
arch/sh/kernel/cpu/sh4a/clock-sh7786.c
arch/sh/kernel/cpu/sh4a/clock-shx3.c
arch/sparc/kernel/perf_event.c
block/bsg.c
drivers/acpi/apei/ghes.c
drivers/block/loop.c
drivers/block/mtip32xx/mtip32xx.c
drivers/block/nbd.c
drivers/block/pktcdvd.c
drivers/clk/bcm/clk-bcm2835.c
drivers/clk/keystone/pll.c
drivers/clk/mmp/clk-frac.c
drivers/clk/renesas/renesas-cpg-mssr.c
drivers/clk/rockchip/clk.c
drivers/clk/sirf/clk-atlas6.c
drivers/clk/sirf/clk-atlas7.c
drivers/clk/sirf/clk-prima2.c
drivers/clk/spear/clk-aux-synth.c
drivers/clk/spear/clk-frac-synth.c
drivers/clk/spear/clk-gpt-synth.c
drivers/clk/spear/clk-vco-pll.c
drivers/clk/ti/fapll.c
drivers/clk/ux500/clk-prcc.c
drivers/clk/ux500/clk-prcmu.c
drivers/clocksource/armv7m_systick.c
drivers/cpufreq/loongson1-cpufreq.c
drivers/cpufreq/spear-cpufreq.c
drivers/crypto/marvell/hash.c
drivers/crypto/sunxi-ss/sun4i-ss-core.c
drivers/dma/dmaengine.c
drivers/dma/imx-sdma.c
drivers/dma/xilinx/xilinx_dma.c
drivers/gpio/gpiolib.c
drivers/gpu/drm/drm_edid.c
drivers/gpu/drm/drm_gem.c
drivers/gpu/drm/drm_property.c
drivers/gpu/drm/etnaviv/etnaviv_dump.c
drivers/gpu/drm/i915/i915_gem_gtt.c
drivers/gpu/drm/i915/i915_gem_userptr.c
drivers/gpu/drm/i915/intel_display.c
drivers/gpu/drm/i915/intel_engine_cs.c
drivers/gpu/drm/i915/intel_fbdev.c
drivers/gpu/drm/i915/intel_guc_loader.c
drivers/gpu/drm/i915/intel_overlay.c
drivers/gpu/drm/i915/intel_ringbuffer.c
drivers/gpu/drm/imx/imx-drm-core.c
drivers/gpu/drm/imx/ipuv3-crtc.c
drivers/gpu/drm/msm/dsi/dsi.c
drivers/gpu/drm/msm/dsi/dsi_manager.c
drivers/gpu/drm/msm/edp/edp.c
drivers/gpu/drm/msm/hdmi/hdmi.c
drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
drivers/gpu/drm/msm/msm_drv.c
drivers/gpu/drm/msm/msm_fbdev.c
drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
drivers/gpu/drm/omapdrm/omap_fbdev.c
drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
drivers/gpu/drm/tegra/dc.c
drivers/gpu/drm/tegra/dpaux.c
drivers/gpu/drm/vgem/vgem_fence.c
drivers/gpu/drm/vmwgfx/vmwgfx_context.c
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
drivers/iio/adc/rockchip_saradc.c
drivers/infiniband/core/agent.c
drivers/infiniband/core/ucma.c
drivers/infiniband/core/ucm.c
drivers/infiniband/core/user_mad.c
drivers/infiniband/hw/hfi1/user_sdma.c
drivers/infiniband/hw/mlx4/cm.c
drivers/infiniband/hw/mlx4/mcg.c
drivers/infiniband/hw/mlx5/main.c
drivers/infiniband/hw/mthca/mthca_cmd.c
drivers/infiniband/hw/qedr/verbs.c
drivers/infiniband/hw/usnic/usnic_ib_main.c
drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
drivers/infiniband/hw/usnic/usnic_ib_verbs.c
drivers/infiniband/ulp/ipoib/ipoib_main.c
drivers/input/keyboard/gpio_keys.c
drivers/iommu/ipmmu-vmsa.c
drivers/leds/leds-pca963x.c
drivers/lightnvm/core.c
drivers/md/dm-cache-policy.c
drivers/md/dm-mpath.c
drivers/media/platform/sti/hva/hva-hw.c
drivers/media/rc/sunxi-cir.c
drivers/media/v4l2-core/videobuf2-core.c
drivers/mfd/max8997.c
drivers/mfd/max8998.c
drivers/mfd/twl-core.c
drivers/misc/c2port/c2port-duramar2150.c
drivers/misc/cxl/api.c
drivers/misc/cxl/pci.c
drivers/misc/cxl/phb.c
drivers/misc/mic/scif/scif_dma.c
drivers/mmc/host/omap_hsmmc.c
drivers/mmc/host/sdhci-st.c
drivers/mtd/devices/docg3.c
drivers/mtd/nand/davinci_nand.c
drivers/mtd/nand/nand_base.c
drivers/mtd/spi-nor/spi-nor.c
drivers/net/can/usb/gs_usb.c
drivers/net/ethernet/amd/sun3lance.c
drivers/net/ethernet/broadcom/bgmac.c
drivers/net/ethernet/broadcom/genet/bcmmii.c
drivers/net/ethernet/cadence/macb.c
drivers/net/ethernet/freescale/fec_main.c
drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
drivers/net/ethernet/hisilicon/hns/hns_enet.c
drivers/net/ethernet/i825xx/lasi_82596.c
drivers/net/ethernet/intel/e1000e/ptp.c
drivers/net/ethernet/intel/igb/igb_ptp.c
drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
drivers/net/ethernet/mellanox/mlx4/en_clock.c
drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
drivers/net/ethernet/realtek/8139too.c
drivers/net/ethernet/renesas/sh_eth.c
drivers/net/ethernet/sfc/ptp.c
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
drivers/net/ethernet/sun/sunvnet_common.c
drivers/net/ethernet/ti/davinci_emac.c
drivers/net/ethernet/ti/netcp_core.c
drivers/net/phy/mdio-xgene.c
drivers/net/vrf.c
drivers/net/vxlan.c
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
drivers/net/wireless/intel/iwlwifi/mvm/d3.c
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
drivers/nvdimm/namespace_devs.c
drivers/oprofile/nmi_timer_int.c
drivers/parport/parport_pc.c
drivers/phy/phy-rockchip-inno-usb2.c
drivers/phy/phy-rockchip-usb.c
drivers/phy/phy-ti-pipe3.c
drivers/pinctrl/core.c
drivers/pinctrl/sunxi/pinctrl-sunxi.c
drivers/powercap/intel_rapl.c
drivers/power/supply/ab8500_charger.c
drivers/power/supply/bq25890_charger.c
drivers/power/supply/da9150-charger.c
drivers/power/supply/pda_power.c
drivers/power/supply/twl4030_charger.c
drivers/regulator/fixed.c
drivers/rtc/rtc-hid-sensor-time.c
drivers/rtc/rtc-snvs.c
drivers/s390/block/dasd_eckd.c
drivers/s390/block/dasd_eer.c
drivers/s390/scsi/zfcp_fsf.c
drivers/scsi/cxlflash/superpipe.c
drivers/sh/clk/cpg.c
drivers/soc/rockchip/pm_domains.c
drivers/soc/ti/knav_qmss_queue.c
drivers/spi/spi-s3c64xx.c
drivers/staging/android/ion/ion.c
drivers/staging/android/ion/ion_dummy_driver.c
drivers/staging/android/ion/ion_heap.c
drivers/staging/android/ion/tegra/tegra_ion.c
drivers/staging/lustre/lnet/libcfs/tracefile.c
drivers/staging/lustre/lustre/ldlm/ldlm_flock.c
drivers/staging/lustre/lustre/llite/llite_lib.c
drivers/staging/lustre/lustre/llite/namei.c
drivers/staging/lustre/lustre/obdclass/obd_config.c
drivers/staging/lustre/lustre/osc/osc_request.c
drivers/thermal/int340x_thermal/processor_thermal_device.c
drivers/thermal/tegra/soctherm.c
drivers/thermal/ti-soc-thermal/ti-thermal-common.c
drivers/tty/serial/atmel_serial.c
drivers/tty/serial/mxs-auart.c
drivers/tty/serial/sh-sci.c
drivers/tty/vt/vt.c
drivers/usb/dwc2/platform.c
drivers/usb/gadget/legacy/nokia.c
drivers/usb/gadget/udc/fsl_udc_core.c
drivers/usb/gadget/udc/mv_udc_core.c
drivers/usb/gadget/udc/omap_udc.c
drivers/usb/gadget/udc/pxa25x_udc.c
drivers/usb/gadget/udc/pxa27x_udc.c
drivers/usb/gadget/udc/s3c-hsudc.c
drivers/usb/host/ehci-fsl.c
drivers/usb/host/ehci-msm.c
drivers/usb/host/ohci-omap.c
drivers/usb/musb/am35x.c
drivers/usb/musb/blackfin.c
drivers/usb/musb/da8xx.c
drivers/usb/musb/davinci.c
drivers/usb/musb/musb_core.c
drivers/usb/musb/tusb6010.c
drivers/usb/musb/ux500.c
drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
drivers/xen/pcpu.c
drivers/xen/xenbus/xenbus_probe_frontend.c
fs/9p/fid.c
fs/9p/vfs_inode.c
fs/9p/vfs_inode_dotl.c
fs/binfmt_elf.c
fs/binfmt_elf_fdpic.c
fs/block_dev.c
fs/btrfs/disk-io.c
fs/btrfs/extent_io.c
fs/btrfs/file.c
fs/btrfs/inode.c
fs/btrfs/relocation.c
fs/btrfs/scrub.c
fs/btrfs/send.c
fs/btrfs/volumes.c
fs/ceph/caps.c
fs/ceph/inode.c
fs/ceph/snap.c
fs/cifs/connect.c
fs/cifs/inode.c
fs/cifs/smb1ops.c
fs/coredump.c
fs/ecryptfs/keystore.c
fs/exec.c
fs/ext4/extents.c
fs/ext4/ialloc.c
fs/ext4/readpage.c
fs/ext4/resize.c
fs/f2fs/data.c
fs/fuse/dir.c
fs/fuse/file.c
fs/gfs2/glock.c
fs/gfs2/inode.c
fs/hfs/brec.c
fs/hfsplus/brec.c
fs/jffs2/acl.c
fs/namespace.c
fs/nfsd/nfs3xdr.c
fs/nfsd/nfsfh.c
fs/ocfs2/dir.c
fs/ocfs2/export.c
fs/ocfs2/file.c
fs/ocfs2/inode.c
fs/ocfs2/localalloc.c
fs/ocfs2/namei.c
fs/ocfs2/suballoc.c
fs/overlayfs/super.c
fs/proc/root.c
fs/proc/self.c
fs/proc/thread_self.c
fs/ubifs/find.c
fs/ubifs/gc.c
fs/ubifs/lpt_commit.c
ipc/mqueue.c
ipc/msg.c
kernel/events/core.c
kernel/nsproxy.c
kernel/padata.c
mm/mmap.c
mm/swapfile.c
net/9p/client.c
net/atm/lec.c
net/atm/proc.c
net/bridge/br_forward.c
net/ceph/ceph_common.c
net/ceph/osdmap.c
net/core/dev.c
net/core/neighbour.c
net/ipv4/inet_connection_sock.c
net/ipv4/ip_output.c
net/ipv4/netfilter/arp_tables.c
net/ipv4/netfilter/ip_tables.c
net/ipv6/addrconf.c
net/ipv6/calipso.c
net/ipv6/icmp.c
net/ipv6/ip6_fib.c
net/ipv6/netfilter/ip6_tables.c
net/ipv6/route.c
net/mac80211/chan.c
net/mpls/af_mpls.c
net/netfilter/ipvs/ip_vs_ctl.c
net/netfilter/nfnetlink_queue.c
net/netfilter/nf_tables_api.c
net/openvswitch/datapath.c
net/rds/ib_cm.c
net/rds/rdma_transport.c
net/rds/send.c
net/rxrpc/conn_client.c
net/xfrm/xfrm_policy.c
security/apparmor/path.c
security/integrity/ima/ima_api.c
security/keys/keyctl.c
security/selinux/hooks.c
sound/soc/sunxi/sun4i-codec.c
tools/testing/nvdimm/test/nfit.c
virt/kvm/eventfd.c
--8323329-672903137-1478812712=:1970--
