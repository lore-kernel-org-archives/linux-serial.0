From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
Date: Wed, 21 Nov 2012 16:57:05 +0100
Message-ID: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121155312.GX4398@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121121155312.GX4398-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
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
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

devicetrees may have a linux,stdout-path or stdout-path property
in the chosen node describing the console device. This adds a helper
function to match a device against this property and retrieve the options
so a driver can call add_preferred_console for a matching device.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/of/base.c  |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |    7 +++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f2f63c8..72c49ce 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1470,3 +1470,49 @@ const char *of_prop_next_string(struct property *prop, const char *cur)
 	return curv;
 }
 EXPORT_SYMBOL_GPL(of_prop_next_string);
+
+/**
+ * of_device_is_stdout_path - check if a device node matches the
+ *			      linux,stdout-path property
+ * @np:		Pointer to the given device_node
+ * @option:	parsed option
+ *
+ * Check if this device node matches the linux,stdout-path property
+ * in the chosen node. return true if yes, false otherwise.
+ */
+int of_device_is_stdout_path(struct device_node *dn, char **option)
+{
+	const char *name;
+	struct device_node *dn_stdout;
+	bool is_stdout = 0;
+	const char *tmp;
+	const char *tmp_option;
+
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		name = of_get_property(of_chosen, "stdout-path", NULL);
+
+	if (name == NULL)
+		return 0;
+
+	tmp_option = strchr(name, ':');
+
+	tmp = kstrndup(name, strlen(name) - strlen(tmp_option), GFP_KERNEL);
+	if (!tmp)
+		return 0;
+
+	dn_stdout = of_find_node_by_path(tmp);
+
+	if (dn_stdout && dn_stdout == dn) {
+		is_stdout = 1;
+		tmp_option++;
+		*option = kstrdup(tmp_option, GFP_KERNEL);
+	}
+
+	of_node_put(dn_stdout);
+
+	kfree(tmp);
+
+	return is_stdout;
+}
+EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
diff --git a/include/linux/of.h b/include/linux/of.h
index 681a6c8..6a82e3f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -323,6 +323,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
 		s;						\
 		s = of_prop_next_string(prop, s))
 
+int of_device_is_stdout_path(struct device_node *dn, char **option);
+
 #else /* CONFIG_OF */
 
 static inline const char* of_node_full_name(struct device_node *np)
@@ -450,6 +452,11 @@ static inline int of_machine_is_compatible(const char *compat)
 	return 0;
 }
 
+static inline int of_device_is_stdout_path(struct device_node *dn, char **option)
+{
+	return 0;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #define of_property_for_each_u32(np, propname, prop, p, u) \
-- 
1.7.10.4
