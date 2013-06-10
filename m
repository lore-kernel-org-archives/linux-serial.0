From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2 03/11] regmap: Add regmap_field APIs
Date: Mon, 10 Jun 2013 10:21:58 +0100
Message-ID: <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370855828-5318-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

It is common to access regmap registers at bit level, using
regmap_update_bits or regmap_read functions, however the end user has to
take care of a mask or shifting. This becomes overhead when such use
cases are high. Having a common function to do this is much convenient
and less error prone.

The idea of regmap_field is simple, regmap_field gives a logical
structure to bits of the regmap register, and the driver can use this
logical entity without the knowledge of the bit postions and masks all
over the code. This way code looks much neat and it need not handle the
masks, shifts every time it access the those entities.

With this new regmap_field_read/write apis the end user can setup a
regmap field using regmap_field_init and use the return regmap_field to
read write the register field without worrying about the masks or
shifts.

Also this apis will be usefull for drivers which are based on regmaps,
like some clocks or pinctrls which can work on the regmap_fields
directly without having to worry about bit positions.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
CC: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/base/regmap/internal.h |    8 +++
 drivers/base/regmap/regmap.c   |  104 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h         |   42 ++++++++++++++++
 3 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index c130536..c5f6ebd 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -174,6 +174,14 @@ struct regmap_range_node {
 	unsigned int window_len;
 };
 
+struct regmap_field {
+	struct regmap *regmap;
+	unsigned int mask;
+	/* lsb */
+	unsigned int shift;
+	unsigned int reg;
+};
+
 #ifdef CONFIG_DEBUG_FS
 extern void regmap_debugfs_initcall(void);
 extern void regmap_debugfs_init(struct regmap *map, const char *name);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index a941dcf..8d967cc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -801,6 +801,67 @@ struct regmap *devm_regmap_init(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init);
 
+static void regmap_field_init(struct regmap_field *rm_field,
+	struct regmap *regmap, struct reg_field reg_field)
+{
+	int field_bits = reg_field.msb - reg_field.lsb + 1;
+	rm_field->regmap = regmap;
+	rm_field->reg = reg_field.reg;
+	rm_field->shift = reg_field.lsb;
+	rm_field->mask = ((BIT(field_bits) - 1) << reg_field.lsb);
+}
+
+/**
+ * devm_regmap_field_alloc(): Allocate and initialise a register field
+ * in a register map.
+ *
+ * @dev: Device that will be interacted with
+ * @regmap: regmap bank in which this register field is located.
+ * @reg_field: Register field with in the bank.
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap_field. The regmap_field will be automatically freed
+ * by the device management code.
+ */
+struct regmap_field *devm_regmap_field_alloc(struct device *dev,
+		struct regmap *regmap, struct reg_field reg_field)
+{
+	struct regmap_field *rm_field = devm_kzalloc(dev,
+					sizeof(*rm_field), GFP_KERNEL);
+	if (!rm_field)
+		return ERR_PTR(-ENOMEM);
+
+	regmap_field_init(rm_field, regmap, reg_field);
+
+	return rm_field;
+
+}
+EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
+/**
+ * regmap_field_alloc(): Allocate and initialise a register field
+ * in a register map.
+ *
+ * @regmap: regmap bank in which this register field is located.
+ * @reg_field: Register field with in the bank.
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap_field. The regmap_field should be freed by the
+ * user once its finished working with it using regmap_field_free().
+ */
+struct regmap_field *regmap_field_alloc(struct regmap *regmap,
+		struct reg_field reg_field)
+{
+	struct regmap_field *rm_field = kzalloc(sizeof(*rm_field), GFP_KERNEL);
+
+	if (!rm_field)
+		return ERR_PTR(-ENOMEM);
+
+	regmap_field_init(rm_field, regmap, reg_field);
+
+	return rm_field;
+}
+EXPORT_SYMBOL_GPL(regmap_field_alloc);
+
 /**
  * regmap_reinit_cache(): Reinitialise the current register cache
  *
@@ -1249,6 +1310,23 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_raw_write);
 
+/**
+ * regmap_field_write(): Write a value to a single register field
+ *
+ * @field: Register field to write to
+ * @val: Value to be written
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+
+int regmap_field_write(struct regmap_field *field, unsigned int val)
+{
+	return regmap_update_bits(field->regmap, field->reg,
+				field->mask, val << field->shift);
+}
+EXPORT_SYMBOL_GPL(regmap_field_write);
+
 /*
  * regmap_bulk_write(): Write multiple registers to the device
  *
@@ -1532,6 +1610,32 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
+ * regmap_field_read(): Read a value to a single register field
+ *
+ * @field: Register field to read from
+ * @val: Pointer to store read value
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+
+int regmap_field_read(struct regmap_field *field, unsigned int *val)
+{
+	int ret;
+	unsigned int reg_val;
+	ret = regmap_read(field->regmap, field->reg, &reg_val);
+	if (ret != 0)
+		return ret;
+
+	reg_val &= field->mask;
+	reg_val >>= field->shift;
+	*val = reg_val;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_field_read);
+
+/**
  * regmap_bulk_read(): Read multiple registers from the device
  *
  * @map: Register map to write to
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 02d84e2..557a54e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -15,6 +15,8 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
+#include <linux/device.h>
+#include <linux/slab.h>
 
 struct module;
 struct device;
@@ -23,6 +25,7 @@ struct irq_domain;
 struct spi_device;
 struct regmap;
 struct regmap_range_cfg;
+struct regmap_field;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -412,6 +415,45 @@ bool regmap_reg_in_ranges(unsigned int reg,
 			  unsigned int nranges);
 
 /**
+ * Description of an register field
+ *
+ * @reg: Offset of the register within the regmap bank
+ * @lsb: lsb of the register field.
+ * @reg: msb of the register field.
+ */
+struct reg_field {
+	unsigned int reg;
+	unsigned int lsb;
+	unsigned int msb;
+};
+
+#define REG_FIELD(_reg, _lsb, _msb) {		\
+				.reg = _reg,	\
+				.lsb = _lsb,	\
+				.msb = _msb,	\
+				}
+
+struct regmap_field *regmap_field_alloc(struct regmap *regmap,
+		struct reg_field reg_field);
+
+struct regmap_field *devm_regmap_field_alloc(struct device *dev,
+		struct regmap *regmap, struct reg_field reg_field);
+
+static inline void regmap_field_free(struct regmap_field *field)
+{
+	kfree(field);
+}
+
+static inline void devm_regmap_field_free(struct device *dev,
+	struct regmap_field *field)
+{
+	devm_kfree(dev, field);
+}
+
+int regmap_field_read(struct regmap_field *field, unsigned int *val);
+int regmap_field_write(struct regmap_field *field, unsigned int val);
+
+/**
  * Description of an IRQ for the generic regmap irq_chip.
  *
  * @reg_offset: Offset of the status/mask register within the bank
-- 
1.7.6.5
